import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/chat/conversations/domain/repositories/i_create_conversation_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: ICreateConversationRepository)
class CreateConversationRepository extends PgRepository
    implements ICreateConversationRepository {
  const CreateConversationRepository(super.pool);

  @override
  Future<String> create({
    required String creatorId,
    required List<String> participantIds,
  }) => guarded(() async {
    final memberIds = <String>{creatorId, ...participantIds}.toList();

    return pool.runTx((session) async {
      final conversationResult = await session.execute(
        Sql.named(
          '''
            INSERT INTO chat.conversations DEFAULT VALUES RETURNING id
          '''
              .trim(),
        ),
      );

      final conversationId = conversationResult.mapFirst(
        (row) => row.cellId('id'),
      );

      for (final userId in memberIds) {
        await session.execute(
          Sql.named(
            '''
              INSERT INTO chat.conversation_members (conversation_id, user_id)
              VALUES (@conversation_id, @user_id)
              ON CONFLICT (conversation_id, user_id) DO NOTHING
            '''
                .trim(),
          ),
          parameters: {'conversation_id': conversationId, 'user_id': userId},
        );
      }

      return conversationId;
    });
  });

  @override
  Future<String?> findDirectConversation({
    required String userA,
    required String userB,
  }) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
            SELECT cm.conversation_id
            FROM chat.conversation_members cm
            INNER JOIN (
              SELECT conversation_id
              FROM chat.conversation_members
              GROUP BY conversation_id
              HAVING COUNT(*) = 2
            ) two_member ON two_member.conversation_id = cm.conversation_id
            WHERE cm.user_id IN (@user_a, @user_b)
            GROUP BY cm.conversation_id
            HAVING COUNT(DISTINCT cm.user_id) = 2
            LIMIT 1
            '''
            .trim(),
      ),
      parameters: {'user_a': userA, 'user_b': userB},
    );

    return result.mapFirstOrNull((row) => row.cellId('conversation_id'));
  });
}
