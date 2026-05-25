import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/repositories/i_verify_registration_email_repository.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/value_objects/pending_registration_verification.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IVerifyRegistrationEmailRepository)
class VerifyRegistrationEmailRepository extends PgRepository
    implements IVerifyRegistrationEmailRepository {
  const VerifyRegistrationEmailRepository(super.pool);

  @override
  Future<PendingRegistrationVerification?> findVerificationById(String id) =>
      guarded(() async {
        final result = await pool.execute(
          Sql.named(
            '''
        SELECT id, code_hash, expires_at, verified_at, attempts
        FROM auth.pending_registrations
        WHERE id = @id
        LIMIT 1
        '''
                .trim(),
          ),
          parameters: {'id': id},
        );

        return result.mapFirstOrNull((row) {
          final column = row.columns;
          return PendingRegistrationVerification(
            id: id,
            codeHash: column['code_hash'] as String,
            expiresAt: column['expires_at'] as DateTime,
            verifiedAt: column['verified_at'] as DateTime?,
            attempts: column['attempts'] as int,
          );
        });
      });

  @override
  Future<void> incrementAttempts(String id) => guarded(() async {
    await pool.execute(
      Sql.named(
        '''
        UPDATE auth.pending_registrations
        SET attempts = attempts + 1
        WHERE id = @id
        '''
            .trim(),
      ),
      parameters: {'id': id},
    );
  });

  @override
  Future<void> markVerified(String id) => guarded(() async {
    await pool.execute(
      Sql.named(
        '''
        UPDATE auth.pending_registrations
        SET verified_at = NOW()
        WHERE id = @id
        '''
            .trim(),
      ),
      parameters: {'id': id},
    );
  });
}
