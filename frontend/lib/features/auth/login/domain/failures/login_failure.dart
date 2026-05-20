sealed class LoginFailure {
  const LoginFailure();
}

final class InvalidCredentialsFailure extends LoginFailure {
  const InvalidCredentialsFailure();
}

final class NetworkFailure extends LoginFailure {
  const NetworkFailure();
}

final class UnknownLoginFailure extends LoginFailure {
  final String message;
  const UnknownLoginFailure(this.message);
}
