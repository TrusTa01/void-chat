import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/pending_registration_for_completion.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: ICompleteProfileRepository)
class CompleteProfileRepository extends PgRepository
    implements ICompleteProfileRepository {
  const CompleteProfileRepository(super.pool);

  @override
  Future<void> deleteById(String id) => guarded(
    () => pool.execute(
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
        final result = await pool.execute(
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
        return result.mapFirstOrNull((row) {
          final column = row.columns;
          return PendingRegistrationForCompletion(
            id: id,
            login: column['login'] as String,
            email: column['email'] as String,
            passwordHash: column['password_hash'] as String,
            verifiedAt: column['verified_at'] as DateTime?,
          );
        });
      });
}
