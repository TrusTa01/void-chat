import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/features/auth/login/request/domain/repositories/i_request_login_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IRequestLoginRepository)
class RequestLoginRepository
    with PgErrorHandling
    implements IRequestLoginRepository {
  final Pool<Connection> _pool;

  const RequestLoginRepository(this._pool);

  @override
  Future<void> insertCode({
    required String userId,
    required String codeHash,
    required DateTime expiresAt,
  }) => guarded(
    () => _pool.execute(
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
}
