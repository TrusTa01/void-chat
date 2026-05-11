/// Machine-readable error codes produced by the Postgres data layer.
///
/// These codes appear in the `error.code` field of HTTP responses produced by
/// the `errorMiddleware`. They are part of the public API contract — keep them
/// stable and in SCREAMING_SNAKE_CASE; the frontend matches against them.
abstract class PgErrorCodes {
  // --- Generic conflict (HTTP 409) ---

  /// Unique constraint violation that the repository did not refine further.
  static const String conflict = 'CONFLICT';

  // --- Validation (HTTP 400) ---

  /// Foreign key violation: referenced row does not exist.
  static const String fkViolation = 'FK_VIOLATION';

  /// CHECK constraint failed.
  static const String checkViolation = 'CHECK_VIOLATION';

  /// Input value longer than the column allows.
  static const String valueTooLong = 'VALUE_TOO_LONG';

  /// Input is not a valid representation for the target type
  /// (e.g. malformed UUID, bad integer).
  static const String invalidDataFormat = 'INVALID_DATA_FORMAT';

  // --- Server-side (HTTP 5xx) ---

  /// Database is unreachable (network, refused connection, fatal startup).
  static const String dbUnavailable = 'DB_UNAVAILABLE';

  /// Database query timed out on the client side.
  static const String dbTimeout = 'DB_TIMEOUT';

  /// Postgres canceled the query (e.g. statement_timeout).
  static const String dbQueryCanceled = 'DB_QUERY_CANCELED';

  /// Transient retryable error (serialization_failure / deadlock).
  /// TODO: handle with automatic retry at the transaction wrapper level
  ///       before falling through to clients.
  static const String dbRetryable = 'DB_RETRYABLE';

  /// NOT NULL violation: schema disagrees with the code. This is a developer
  /// bug, not user input — surfaced as 500 so monitoring picks it up.
  static const String dbNullViolation = 'DB_NULL_VIOLATION';

  /// Catch-all for unrecognized SQLSTATE codes.
  static const String dbError = 'DB_ERROR';
}
