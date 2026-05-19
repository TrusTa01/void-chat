import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/features/auth/login/verify/domain/repositories/i_verify_login_email_repository.dart';
import 'package:backend/src/features/auth/login/verify/domain/value_objects/login_email_code.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IVerifyLoginEmailRepository)
class VerifyLoginEmailRepository
    with PgErrorHandling
    implements IVerifyLoginEmailRepository {
  final Pool<Connection> _pool;

  const VerifyLoginEmailRepository(this._pool);

  @override
  Future<LoginEmailCode?> findActiveByUserId(String userId) async {
    return guarded(() async {
      final result = await _pool.execute(
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
      if (result.isEmpty) return null;

      final column = result.first.toColumnMap();
      final id = (column['id']! as Object).toString();

      return LoginEmailCode(
        id: id,
        codeHash: column['code_hash'] as String,
        expiresAt: column['expires_at'] as DateTime,
        attempts: column['attempts'] as int,
      );
    });
  }

  @override
  Future<void> incrementAttempts(String id) => guarded(() async {
    await _pool.execute(
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
    () async => _pool.execute(
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
