import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/pending_registration_for_completion.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: ICompleteProfileRepository)
class CompleteProfileRepository
    with PgErrorHandling
    implements ICompleteProfileRepository {
  final Pool<Connection> _pool;

  const CompleteProfileRepository(this._pool);

  @override
  Future<void> deleteById(String id) => guarded(
    () => _pool.execute(
      Sql.named(
        '''
        DELETE FROM auth.pending_registrations
        WHERE id = @id
        '''
            .trim(),
      ),
      parameters: {'id': id},
    ),
  );

  @override
  Future<PendingRegistrationForCompletion?> findForCompletionById(String id) =>
      guarded(() async {
        final result = await _pool.execute(
          Sql.named(
            '''
            SELECT id, login, email, password_hash, verified_at
            FROM auth.pending_registrations
            WHERE id = @id
            LIMIT 1
            '''
                .trim(),
          ),
          parameters: {'id': id},
        );
        if (result.isEmpty) return null;

        final column = result.first.toColumnMap();
        return PendingRegistrationForCompletion(
          id: id,
          login: column['login'] as String,
          email: column['email'] as String,
          passwordHash: column['password_hash'] as String,
          verifiedAt: column['verified_at'] as DateTime?,
        );
      });
}
