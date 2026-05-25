import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: ISessionRepository)
class PostgresSessionRepository extends PgRepository
    implements ISessionRepository {
  const PostgresSessionRepository(super.pool);

  @override
  Future<void> create(String userId, String tokenHash, DateTime expiresAt) {
    return guarded(() async {
      await pool.execute(
        Sql.named(
          '''
        INSERT INTO auth.sessions (user_id, token_hash, expires_at)
        VALUES (@user_id, @token_hash, @expires_at)
        '''
              .trim(),
        ),
        parameters: {
          'user_id': userId,
          'token_hash': tokenHash,
          'expires_at': expiresAt,
        },
      );
    });
  }

  @override
  Future<String?> findUserIdByTokenHash(String tokenHash) {
    return guarded(() async {
      final result = await pool.execute(
        Sql.named(
          '''
        SELECT user_id
        FROM auth.sessions
        WHERE token_hash = @token_hash AND expires_at > NOW()
        '''
              .trim(),
        ),
        parameters: {'token_hash': tokenHash},
      );

      return result.mapFirstOrNull((row) => row.cellId('user_id'));
    });
  }

  @override
  Future<void> deleteTokenByHash(String tokenHash) {
    return guarded(() async {
      await pool.execute(
        Sql.named(
          '''
          DELETE FROM auth.sessions
          WHERE token_hash = @token_hash
          '''
              .trim(),
        ),
        parameters: {'token_hash': tokenHash},
      );
    });
  }

  @override
  Future<void> deleteAllByUserId(String userId) {
    return guarded(() async {
      await pool.execute(
        Sql.named(
          '''
        DELETE FROM auth.sessions
        WHERE user_id = @user_id
        '''
              .trim(),
        ),
        parameters: {'user_id': userId},
      );
    });
  }
}
