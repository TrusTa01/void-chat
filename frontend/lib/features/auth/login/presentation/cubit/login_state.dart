import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final UserEntity user;
  const LoginSuccess(this.user);
}

final class LoginCodeSent extends LoginState {
  final String identifier;
  const LoginCodeSent(this.identifier);
}

final class LoginError extends LoginState {
  final LoginFailure failure;
  const LoginError(this.failure);
}
