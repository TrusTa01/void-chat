import 'dart:async';
import 'dart:io';

import 'package:backend/core/di/locator.dart';
import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/core/errors/pg_error_codes.dart';
import 'package:postgres/postgres.dart';

/// Wraps repository methods that talk to Postgres and converts low-level
/// driver/network exceptions into domain [AppException]s.
///
/// The mixin intentionally knows only generic SQLSTATE classes. Per-table
/// specifics (e.g. which UNIQUE index means "EMAIL_TAKEN") belong to the
/// concrete repository — override [mapUniqueViolation] to refine 23505.
///
/// SQLSTATE reference:
/// https://www.postgresql.org/docs/current/errcodes-appendix.html
mixin PgErrorHandling {
  /// Override hook for SQLSTATE 23505 (unique_violation).
  ///
  /// The default returns a generic [ConflictException]; concrete repositories
  /// inspect [ServerException.constraintName] (exact match, not substring)
  /// and return a more specific exception with a stable error code.
  AppException mapUniqueViolation(ServerException e) {
    return const ConflictException(
      PgErrorCodes.conflict,
      'Resource already exists',
    );
  }

  /// Runs [body] and translates Postgres / network failures into
  /// [AppException]s before they leak out of the data layer.
  Future<T> guarded<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on ServerException catch (e, st) {
      throw _mapServerException(e, st);
    } on SocketException catch (e, st) {
      // Network-level failure: DB unreachable, connection refused, etc.
      talker.error('Postgres socket failure', e, st);
      throw const ServiceUnavailableException(
        PgErrorCodes.dbUnavailable,
        'Database is unavailable. Please try again later.',
      );
    } on TimeoutException catch (e, st) {
      // Client-side timeout while waiting for the DB.
      talker.error('Postgres timeout', e, st);
      throw const GatewayTimeoutException(
        PgErrorCodes.dbTimeout,
        'Database request timed out.',
      );
    }
  }

  /// Translates a Postgres [ServerException] into an [AppException].
  AppException _mapServerException(ServerException e, StackTrace st) {
    final code = e.code;

    // SQLSTATE class 08 — Connection Exception. The driver may surface these
    // as ServerException rather than SocketException when the server replies
    // mid-handshake or rejects the connection at the protocol level.
    if (code != null && code.startsWith('08')) {
      talker.error('Postgres connection error: $code', e, st);
      return const ServiceUnavailableException(
        PgErrorCodes.dbUnavailable,
        'Database connection error',
      );
    }

    switch (code) {
      // --- Class 23 — Integrity Constraint Violation ---

      case '23505':
        // unique_violation: defer to per-repository hook for EMAIL_TAKEN, etc.
        talker.warning(
          'Postgres unique violation on '
          '${e.tableName ?? '<unknown table>'}.'
          '${e.constraintName ?? '<unknown constraint>'}',
        );
        return mapUniqueViolation(e);

      case '23503':
        // foreign_key_violation: usually a bad reference in the request body.
        talker.warning(
          'Postgres FK violation: ${e.constraintName ?? '<unknown>'}',
        );
        return const ValidationException(
          PgErrorCodes.fkViolation,
          'Referenced record does not exist',
        );

      case '23502':
        // not_null_violation. Domain value objects keep their fields
        // non-nullable, so reaching this means the schema disagrees with the
        // code — a developer bug. Surface as 500, not 400, so monitoring
        // picks it up.
        talker.error(
          'Postgres NOT NULL violation on '
          '${e.tableName ?? '<unknown>'}.${e.columnName ?? '<unknown>'}',
          e,
          st,
        );
        return const InternalServerException(
          PgErrorCodes.dbNullViolation,
          'Internal data integrity error',
        );

      case '23514':
        // check_violation. Treated as 400 because most CHECK constraints
        // mirror business rules (length, ranges, enum-like text).
        // TODO: if a CHECK is added that defends against developer bugs only,
        //       log it and return InternalServerException instead.
        talker.warning(
          'Postgres CHECK violation: ${e.constraintName ?? '<unknown>'}',
        );
        return const ValidationException(
          PgErrorCodes.checkViolation,
          'Value violates a database constraint',
        );

      // --- Class 22 — Data Exception ---

      case '22001':
        // string_data_right_truncation
        return const ValidationException(
          PgErrorCodes.valueTooLong,
          'Input value exceeds the maximum allowed length',
        );

      case '22P02':
        // invalid_text_representation (e.g. malformed UUID, non-numeric text)
        return const ValidationException(
          PgErrorCodes.invalidDataFormat,
          'Invalid input format',
        );

      // --- Class 40 — Transaction Rollback ---

      case '40001': // serialization_failure
      case '40P01': // deadlock_detected
        // TODO: retry the transaction automatically (with backoff and a small
        //       attempt budget) at the transaction wrapper level before
        //       letting this reach the client.
        talker.warning('Postgres retryable error: $code');
        return const ServiceUnavailableException(
          PgErrorCodes.dbRetryable,
          'Concurrent update conflict, please retry',
        );

      // --- Class 57 — Operator Intervention ---

      case '57014':
        // query_canceled (commonly via statement_timeout).
        talker.warning('Postgres query canceled');
        return const GatewayTimeoutException(
          PgErrorCodes.dbQueryCanceled,
          'Query canceled',
        );

      // --- Anything else: treat as an internal error ---

      default:
        talker.error('Unhandled Postgres error: $code', e, st);
        return const InternalServerException(
          PgErrorCodes.dbError,
          'Internal database error',
        );
    }
  }
}
