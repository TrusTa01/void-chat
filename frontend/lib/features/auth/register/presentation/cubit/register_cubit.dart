import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_password_use_case.dart';
import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';
import 'package:void_chat/features/auth/register/domain/use_cases/cancel_registration_use_case.dart';
import 'package:void_chat/features/auth/register/domain/use_cases/complete_registration_use_case.dart';
import 'package:void_chat/features/auth/register/domain/use_cases/start_registration_use_case.dart';
import 'package:void_chat/features/auth/register/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_state.dart';
import 'package:void_chat/core/auth/auth_cubit.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final IStartRegistrationUseCase _startUseCase;
  final IVerifyRegistrationEmailUseCase _verifyUseCase;
  final ICompleteRegistrationUseCase _completeUseCase;
  final ICancelRegistrationUseCase _cancelUseCase;
  final ILoginWithPasswordUseCase _loginUseCase;
  final AuthCubit _authCubit;

  String? _registrationId;
  String? _login;
  String? _email;
  String? _password;

  RegisterCubit(
    this._startUseCase,
    this._verifyUseCase,
    this._completeUseCase,
    this._cancelUseCase,
    this._loginUseCase,
    this._authCubit,
  ) : super(const RegisterInitial());

  Future<void> cancelAndReset() async {
    final registrationId = _registrationId;
    emit(const RegisterLoading());
    try {
      if (registrationId != null) {
        await _cancelUseCase.call(registrationId);
      }
      _clearDraft();
      emit(const RegisterInitial());
    } on RegisterFailure catch (f) {
      emit(RegisterError(f));
    }
  }

  void _clearDraft() {
    _registrationId = null;
    _login = null;
    _email = null;
    _password = null;
  }

  String? get draftEmail => _email;

  Future<void> start({
    required String login,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    try {
      final registrationId = await _startUseCase.call(
        login: login,
        email: email,
        password: password,
      );
      _registrationId = registrationId;
      _login = login;
      _email = email;
      _password = password;
      emit(RegisterStarted(registrationId));
    } on RegisterFailure catch (f) {
      emit(RegisterError(f));
    }
  }

  Future<void> verifyEmail(String code) async {
    final registrationId = _registrationId;
    if (registrationId == null) return;

    emit(const RegisterLoading());
    try {
      await _verifyUseCase.call(
        registrationId: registrationId,
        code: code.trim(),
      );
      emit(const RegisterEmailVerified());
    } on RegisterFailure catch (f) {
      emit(RegisterError(f));
    }
  }

  Future<void> resendCode() async {
    final login = _login;
    final email = _email;
    final password = _password;
    if (login == null || email == null || password == null) return;

    emit(const RegisterLoading());
    try {
      final registrationId = await _startUseCase.call(
        login: login,
        email: email,
        password: password,
      );
      _registrationId = registrationId;
      emit(const RegisterCodeResent());
    } on RegisterFailure catch (f) {
      emit(RegisterError(f));
    }
  }

  Future<void> completeProfile({
    required String username,
    required String displayName,
  }) async {
    final registrationId = _registrationId;
    final email = _email;
    final password = _password;
    if (registrationId == null || email == null || password == null) return;

    emit(const RegisterLoading());
    try {
      await _completeUseCase.call(
        registrationId: registrationId,
        username: username,
        displayName: displayName,
      );
      final user = await _loginUseCase.call(email, password);
      _authCubit.setAuthenticated();
      emit(RegisterCompleted(user));
    } on RegisterFailure catch (f) {
      emit(RegisterError(f));
    } on LoginFailure catch (f) {
      emit(RegisterError(RegisterAutoLoginFailure(f)));
    }
  }
}
