import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/domain/use_cases/login_verify_code_use_case.dart';
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_code_use_case.dart';
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_password_use_case.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/shared/presentation/cubit/auth_cubit.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final ILoginWithPasswordUseCase _passUseCase;
  final ILoginWithCodeUseCase _codeUseCase;
  final ILoginVerifyCodeUseCase _verifyUseCase;
  final AuthCubit _authCubit;

  LoginCubit(
    this._passUseCase,
    this._codeUseCase,
    this._verifyUseCase,
    this._authCubit,
  ) : super(const LoginInitial());

  Future<void> loginWithPass(String identifier, String password) async {
    emit(const LoginLoading());
    try {
      final user = await _passUseCase.call(identifier, password);
      _authCubit.setAuthenticated();
      emit(LoginSuccess(user));
    } on LoginFailure catch (f) {
      emit(LoginError(f));
    }
  }

  Future<void> loginWithcode(String identifier) async {
    emit(const LoginLoading());
    try {
      await _codeUseCase.call(identifier);
      emit(LoginCodeSent(identifier));
    } on LoginFailure catch (f) {
      emit(LoginError(f));
    }
  }

  Future<void> verifyCode(String identifier, String code) async {
    emit(const LoginLoading());
    try {
      final user = await _verifyUseCase.call(identifier, code);
      _authCubit.setAuthenticated();
      emit(LoginSuccess(user));
    } on LoginFailure catch (f) {
      emit(LoginError(f));
    }
  }
}
