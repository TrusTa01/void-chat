import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/register/start/domain/repository/i_pending_registration_repository.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration_record.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IPendingRegistrationRepository)
class PostgresPendingRegistrationRepository extends PgRepository
    implements IPendingRegistrationRepository {
  const PostgresPendingRegistrationRepository(super.pool);

  @override
  Future<String> create(PendingRegistrationRecord data) async {
    return guarded(() async {
      final result = await pool.execute(
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

      return result.mapFirst((row) => row.cellId('id'));
    });
  }
}
