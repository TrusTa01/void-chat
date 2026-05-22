sealed class RegisterFailure {
  const RegisterFailure();
}

final class EmailTakenFailure extends RegisterFailure {
  const EmailTakenFailure();
}

final class UsernameTakenFailure extends RegisterFailure {
  const UsernameTakenFailure();
}

final class InvalidRegistrationFailure extends RegisterFailure {
  const InvalidRegistrationFailure();
}

final class EmailNotVerifiedFailure extends RegisterFailure {
  const EmailNotVerifiedFailure();
}

enum RegisterEmailCodeError { invalid, expired, attemptsExceeded }

final class RegisterEmailCodeFailure extends RegisterFailure {
  final RegisterEmailCodeError type;
  const RegisterEmailCodeFailure(this.type);
}

final class RegisterResendTooSoonFailure extends RegisterFailure {
  const RegisterResendTooSoonFailure();
}

final class RegisterNetworkFailure extends RegisterFailure {
  const RegisterNetworkFailure();
}

final class UnknownRegisterFailure extends RegisterFailure {
  final String message;
  const UnknownRegisterFailure(this.message);
}

final class RegisterAutoLoginFailure extends RegisterFailure {
  final Object cause;
  const RegisterAutoLoginFailure(this.cause);
}
