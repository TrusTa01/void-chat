sealed class LoginFailure {
  const LoginFailure();
}

final class InvalidCredentialsFailure extends LoginFailure {
  const InvalidCredentialsFailure();
}

enum EmailCodeError { invalid, expired, attemptsExceeded }

final class EmailCodeFailure extends LoginFailure {
  final EmailCodeError type;
  const EmailCodeFailure(this.type);
}

final class ResendTooSoonFailure extends LoginFailure {
  const ResendTooSoonFailure();
}

final class NetworkFailure extends LoginFailure {
  const NetworkFailure();
}

final class UnknownLoginFailure extends LoginFailure {
  final String message;
  const UnknownLoginFailure(this.message);
}
