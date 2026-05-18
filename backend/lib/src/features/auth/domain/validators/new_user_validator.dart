import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/auth_field_names.dart';

const int newUserLoginMinLength = 3;
const int newUserLoginMaxLength = 64;
const int newUserUsernameMinLength = 3;
const int newUserUsernameMaxLength = 32;
const int newUserDisplayNameMaxLength = 100;
const int newUserEmailMaxLength = 254;
const int newUserPasswordMinLength = 8;
const int newUserPasswordMaxLength = 128;

final RegExp _loginUsernamePattern = RegExp(r'^[a-zA-Z0-9_-]+$');

/// Pragmatic mailbox+domain check — not full RFC 5322, avoids clearly invalid input.
final RegExp _emailPattern = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
);

final RegExp _passwordHasLetter = RegExp(r'\p{L}', unicode: true);
final RegExp _passwordHasDigit = RegExp(r'\p{N}', unicode: true);

/// Trimmed login/email/username/display name and the raw password (not trimmed).
typedef NormalizedNewUserFields = ({
  String login,
  String password,
  String email,
  String username,
  String displayName,
});

/// Result of [validateNewUserInput]: the normalized values together with
/// every [FieldError] discovered during the pass.
///
/// Keeping these together lets the caller decide what to do (throw a
/// [ValidationFailedException] when [errors] is non-empty, or proceed with
/// [normalized] when it is empty).
typedef NewUserValidationResult = ({
  NormalizedNewUserFields normalized,
  List<FieldError> errors,
});

/// Trimmed login/email and the raw password (not trimmed).
typedef NormalizedStartRegistrationFields = ({
  String login,
  String email,
  String password,
});

/// Result of [validateStartRegistrationInput].
typedef StartRegistrationValidationResult = ({
  NormalizedStartRegistrationFields normalized,
  List<FieldError> errors,
});

/// Aggregates every validation problem into a single [FieldError] per field.
///
/// Rationale for at-most-one error per field: it keeps the response payload
/// small, makes the frontend mapping trivial (one inline error per input),
/// and avoids overwhelming the user with multiple complaints about the same
/// input. The most blocking issue (length/empty) wins; secondary issues
/// (format, complexity) are merged into a single descriptive message.
NewUserValidationResult validateNewUserInput({
  required String login,
  required String password,
  required String email,
  required String username,
  required String displayName,
}) {
  final trimmedLogin = login.trim();
  final trimmedEmail = email.trim();
  final trimmedUsername = username.trim();
  final trimmedDisplayName = displayName.trim();

  final errors = <FieldError>[];

  // Login
  final loginError = _validateLogin(trimmedLogin);
  if (loginError != null) errors.add(loginError);

  // Password (the raw value, intentionally not trimmed)
  final passwordError = _validatePassword(password);
  if (passwordError != null) errors.add(passwordError);

  // Email
  final emailError = _validateEmail(trimmedEmail);
  if (emailError != null) errors.add(emailError);

  // Username
  final usernameError = _validateUsername(trimmedUsername);
  if (usernameError != null) errors.add(usernameError);

  // Display name
  final displayNameError = _validateDisplayName(trimmedDisplayName);
  if (displayNameError != null) errors.add(displayNameError);

  return (
    normalized: (
      login: trimmedLogin,
      password: password,
      email: trimmedEmail,
      username: trimmedUsername,
      displayName: trimmedDisplayName,
    ),
    errors: errors,
  );
}

StartRegistrationValidationResult validateStartRegistrationInput({
  required String login,
  required String email,
  required String password,
}) {
  final trimmedLogin = login.trim();
  final trimmedEmail = email.trim();

  final errors = <FieldError>[];

  final loginError = _validateLogin(trimmedLogin);
  if (loginError != null) errors.add(loginError);

  final emailError = _validateEmail(trimmedEmail);
  if (emailError != null) errors.add(emailError);

  final passwordError = _validatePassword(password);
  if (passwordError != null) errors.add(passwordError);

  return (
    normalized: (login: trimmedLogin, email: trimmedEmail, password: password),
    errors: errors,
  );
}

FieldError? _validateLogin(String trimmedLogin) {
  if (trimmedLogin.length < newUserLoginMinLength ||
      trimmedLogin.length > newUserLoginMaxLength) {
    return const FieldError(
      field: AuthFieldNames.login,
      code: AuthErrorCodes.invalidLogin,
      message:
          'Login must be between $newUserLoginMinLength and '
          '$newUserLoginMaxLength characters',
    );
  }
  if (!_loginUsernamePattern.hasMatch(trimmedLogin)) {
    return const FieldError(
      field: AuthFieldNames.login,
      code: AuthErrorCodes.invalidLogin,
      message: 'Login may only contain letters, digits, underscore, and hyphen',
    );
  }
  return null;
}

FieldError? _validatePassword(String password) {
  if (password.length < newUserPasswordMinLength ||
      password.length > newUserPasswordMaxLength) {
    return const FieldError(
      field: AuthFieldNames.password,
      code: AuthErrorCodes.invalidPassword,
      message: 'Password must be 8-128 characters',
    );
  }

  if (!_passwordHasLetter.hasMatch(password) ||
      !_passwordHasDigit.hasMatch(password)) {
    return const FieldError(
      field: AuthFieldNames.password,
      code: AuthErrorCodes.invalidPassword,
      message: 'Password must include at least one letter and one number',
    );
  }
  return null;
}

FieldError? _validateEmail(String trimmedEmail) {
  if (trimmedEmail.isEmpty || trimmedEmail.length > newUserEmailMaxLength) {
    return const FieldError(
      field: AuthFieldNames.email,
      code: AuthErrorCodes.invalidEmail,
      message:
          'Email must be a valid address (max $newUserEmailMaxLength characters)',
    );
  }
  if (!_emailPattern.hasMatch(trimmedEmail)) {
    return const FieldError(
      field: AuthFieldNames.email,
      code: AuthErrorCodes.invalidEmail,
      message: 'Email format is invalid',
    );
  }
  return null;
}

FieldError? _validateUsername(String trimmedUsername) {
  if (trimmedUsername.length < newUserUsernameMinLength ||
      trimmedUsername.length > newUserUsernameMaxLength) {
    return const FieldError(
      field: AuthFieldNames.username,
      code: AuthErrorCodes.invalidUsername,
      message:
          'Username must be between $newUserUsernameMinLength and '
          '$newUserUsernameMaxLength characters',
    );
  }
  if (!_loginUsernamePattern.hasMatch(trimmedUsername)) {
    return const FieldError(
      field: AuthFieldNames.username,
      code: AuthErrorCodes.invalidUsername,
      message:
          'Username may only contain letters, digits, underscore, and hyphen',
    );
  }
  return null;
}

FieldError? _validateDisplayName(String trimmedDisplayName) {
  if (trimmedDisplayName.isEmpty) {
    return const FieldError(
      field: AuthFieldNames.displayName,
      code: AuthErrorCodes.invalidDisplayName,
      message: 'Display name must not be empty',
    );
  }
  if (trimmedDisplayName.length > newUserDisplayNameMaxLength) {
    return const FieldError(
      field: AuthFieldNames.displayName,
      code: AuthErrorCodes.invalidDisplayName,
      message:
          'Display name must be at most $newUserDisplayNameMaxLength characters',
    );
  }
  return null;
}
