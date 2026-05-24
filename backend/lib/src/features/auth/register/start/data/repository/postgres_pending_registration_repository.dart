import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/features/auth/register/start/domain/repository/i_pending_registration_repository.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration_record.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IPendingRegistrationRepository)
class PostgresPendingRegistrationRepository
    with PgErrorHandling
    implements IPendingRegistrationRepository {
  final Pool<Connection> _pool;

  PostgresPendingRegistrationRepository(this._pool);

  @override
  Future<String> create(PendingRegistrationRecord data) async {
    return guarded(() async {
      final result = await _pool.execute(
        Sql.named(
          '''
        INSERT INTO auth.pending_registrations (login, email, password_hash, code_hash, expires_at)
        VALUES (@login, @email, @password_hash, @code_hash, @expires_at)
        RETURNING id
          '''
              .trim(),
        ),
        parameters: {
          'login': data.login,
          'email': data.email,
          'password_hash': data.passwordHash,
          'code_hash': data.codeHash,
          'expires_at': data.expiresAt,
        },
      );
      final m = result.first.toColumnMap();
      final id = (m['id']! as Object).toString();
      return id;
    });
  }
}
