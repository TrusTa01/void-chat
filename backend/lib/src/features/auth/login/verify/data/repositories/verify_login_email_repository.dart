import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/login/verify/domain/repositories/i_verify_login_email_repository.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/value_objects/email_code.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IVerifyLoginEmailRepository)
class VerifyLoginEmailRepository extends PgRepository
    implements IVerifyLoginEmailRepository {
  const VerifyLoginEmailRepository(super.pool);

  @override
  Future<EmailCode?> findActiveByUserId(String userId) async {
    return guarded(() async {
      final result = await pool.execute(
        Sql.named(
          '''
        SELECT id, code_hash, expires_at, attempts
        FROM auth.login_email_codes
        WHERE user_id = @user_id
        AND consumed_at IS NULL
        ORDER BY created_at DESC
        LIMIT 1
        '''
              .trim(),
        ),
        parameters: {'user_id': userId},
      );
      return result.mapFirstOrNull((row) {
        final column = row.columns;
        return EmailCode(
          id: row.cellId('id'),
          codeHash: column['code_hash'] as String,
          expiresAt: column['expires_at'] as DateTime,
          attempts: column['attempts'] as int,
        );
      });
    });
  }

  @override
  Future<void> incrementAttempts(String id) => guarded(() async {
    await pool.execute(
      Sql.named(
        '''
        UPDATE auth.login_email_codes
        SET attempts = attempts + 1
        WHERE id = @id
          '''
            .trim(),
      ),
      parameters: {'id': id},
    );
  });

  @override
  Future<void> markConsumed(String id) => guarded(
    () async => pool.execute(
      Sql.named(
        '''
        UPDATE auth.login_email_codes
        SET consumed_at = NOW()
        WHERE id = @id
        '''
            .trim(),
      ),
      parameters: {'id': id},
    ),
  );
}
