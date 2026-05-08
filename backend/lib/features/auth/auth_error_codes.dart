/// Machine-readable error codes for the auth feature.
///
/// Kept here (not in `core/errors`) because they are tied to auth-specific
/// flows. They are part of the public API contract — keep them stable and in
/// SCREAMING_SNAKE_CASE.
abstract class AuthErrorCodes {
  /// Email is already registered (UNIQUE violation on `auth.users.email`).
  static const String emailTaken = 'EMAIL_TAKEN';

  /// Username is already in use (UNIQUE violation on `auth.users.username`).
  static const String usernameTaken = 'USERNAME_TAKEN';
}
