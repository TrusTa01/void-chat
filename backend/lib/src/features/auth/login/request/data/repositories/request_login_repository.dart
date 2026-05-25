import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/login/request/domain/repositories/i_request_login_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IRequestLoginRepository)
class RequestLoginRepository extends PgRepository
    implements IRequestLoginRepository {
  const RequestLoginRepository(super.pool);

  @override
  Future<void> insertCode({
    required String userId,
    required String codeHash,
    required DateTime expiresAt,
  }) => guarded(
    () => pool.execute(
      Sql.named(
        '''
        INSERT INTO auth.login_email_codes (user_id, code_hash, expires_at)
        VALUES (@user_id, @code_hash, @expires_at)
        '''
            .trim(),
      ),
      parameters: {
        'user_id': userId,
        'code_hash': codeHash,
        'expires_at': expiresAt,
      },
    ),
  );

  @override
  Future<DateTime?> findLastCodeCreatedAt(String userId) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
        SELECT created_at
        FROM auth.login_email_codes
        WHERE user_id = @user_id
        ORDER BY created_at DESC
        LIMIT 1
        '''
            .trim(),
      ),
      parameters: {'user_id': userId},
    );

    return result.mapFirstOrNull(
      (row) => row.columns['created_at'] as DateTime,
    );
  });
}
