/// Machine-readable error codes for the auth feature.
///
/// Kept here (not in `core/errors`) because they are tied to auth-specific
/// flows. They are part of the public API contract — keep them stable and in
/// SCREAMING_SNAKE_CASE.
abstract class AuthErrorCodes {
  /// JSON parses but field types or keys do not match [RegisterRequestDto].
  /// Fail-fast at the API boundary, no per-field details.
  static const String invalidRequestFields = 'INVALID_REQUEST_FIELDS';

  // Per-field codes used inside `ValidationFailedException.details` items.
  // Each field gets at most one code per validation pass; the human-readable
  // explanation lives in the `message` of the corresponding [FieldError].

  /// Login fails length / character / blocklist rules.
  static const String invalidLogin = 'INVALID_LOGIN';

  /// Password fails length / complexity rules.
  static const String invalidPassword = 'INVALID_PASSWORD';

  /// Email fails length / format / blocklist rules.
  static const String invalidEmail = 'INVALID_EMAIL';

  /// Username fails length / character / blocklist rules.
  static const String invalidUsername = 'INVALID_USERNAME';

  /// Display name fails length / blocklist rules.
  static const String invalidDisplayName = 'INVALID_DISPLAY_NAME';

  /// Email is already registered (UNIQUE violation on `auth.users.email`).
  static const String emailTaken = 'EMAIL_TAKEN';

  /// Username is already in use (UNIQUE violation on `auth.users.username`).
  static const String usernameTaken = 'USERNAME_TAKEN';

  static const String invalidCredentials = 'INVALID_CREDENTIALS';
}
