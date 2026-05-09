import 'package:backend/core/errors/app_exception.dart';

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

/// Validates registration fields; throws [ValidationException] on failure.
NormalizedNewUserFields validateNewUserInput({
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

  final errors = <String>[];

  if (trimmedLogin.length < newUserLoginMinLength ||
      trimmedLogin.length > newUserLoginMaxLength) {
    errors.add(
      'login must be between $newUserLoginMinLength and $newUserLoginMaxLength characters',
    );
  } else if (!_loginUsernamePattern.hasMatch(trimmedLogin)) {
    errors.add(
      'login may only contain letters, digits, underscore, and hyphen',
    );
  }

  if (password.length < newUserPasswordMinLength ||
      password.length > newUserPasswordMaxLength) {
    errors.add(
      'password must be between $newUserPasswordMinLength and $newUserPasswordMaxLength characters',
    );
  } else {
    if (!_passwordHasLetter.hasMatch(password)) {
      errors.add('password must contain at least one letter');
    }
    if (!_passwordHasDigit.hasMatch(password)) {
      errors.add('password must contain at least one digit');
    }
  }

  if (trimmedEmail.isEmpty || trimmedEmail.length > newUserEmailMaxLength) {
    errors.add(
      'email must be a valid address (max $newUserEmailMaxLength characters)',
    );
  } else if (!_emailPattern.hasMatch(trimmedEmail)) {
    errors.add('email format is invalid');
  }

  if (trimmedUsername.length < newUserUsernameMinLength ||
      trimmedUsername.length > newUserUsernameMaxLength) {
    errors.add(
      'username must be between $newUserUsernameMinLength and $newUserUsernameMaxLength characters',
    );
  } else if (!_loginUsernamePattern.hasMatch(trimmedUsername)) {
    errors.add(
      'username may only contain letters, digits, underscore, and hyphen',
    );
  }

  if (trimmedDisplayName.isEmpty) {
    errors.add('display name must not be empty');
  } else if (trimmedDisplayName.length > newUserDisplayNameMaxLength) {
    errors.add(
      'display name must be at most $newUserDisplayNameMaxLength characters',
    );
  }

  if (errors.isNotEmpty) {
    throw ValidationException('INVALID_FIELDS', errors.join('; '));
  }

  return (
    login: trimmedLogin,
    password: password,
    email: trimmedEmail,
    username: trimmedUsername,
    displayName: trimmedDisplayName,
  );
}
