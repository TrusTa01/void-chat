import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_password_use_case.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/shared/presentation/cubit/auth_cubit.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final ILoginWithPasswordUseCase _useCase;
  final AuthCubit _authCubit;

  LoginCubit(this._useCase, this._authCubit) : super(const LoginInitial());

  Future<void> login(String identifier, String password) async {
    emit(const LoginLoading());
    try {
      final user = await _useCase.call(identifier, password);
      _authCubit.setAuthenticated();
      emit(LoginSuccess(user));
    } on LoginFailure catch (f) {
      emit(LoginError(f));
    }
  }
}
