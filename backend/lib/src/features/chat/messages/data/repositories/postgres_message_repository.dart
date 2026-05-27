import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/chat/messages/domain/repositories/i_message_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IMessageRepository)
class PostgresMessageRepositoryImpl extends PgRepository
    implements IMessageRepository {
  const PostgresMessageRepositoryImpl(super.pool);

  @override
  Future<Map<String, Object?>> insert({
    required String conversationId,
    required String senderId,
    required String text,
  }) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
          INSERT INTO chat.messages (conversation_id, sender_id, text)
          VALUES (@conversation_id, @sender_id, @text)
          RETURNING id, conversation_id, sender_id, text, created_at
        '''
            .trim(),
      ),
      parameters: {
        'conversation_id': conversationId,
        'sender_id': senderId,
        'text': text,
      },
    );

    return result.mapFirst((row) => row.columns);
  });

  @override
  Future<bool> isMember({
    required String conversationId,
    required String userId,
  }) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
          SELECT 1
          FROM chat.conversation_members
          WHERE conversation_id = @conversation_id
          AND user_id = @user_id
        '''
            .trim(),
      ),
      parameters: {'conversation_id': conversationId, 'user_id': userId},
    );
    return result.isNotEmpty;
  });

  @override
  Future<List<String>> listMemberIds(String conversationId) =>
      guarded(() async {
        final result = await pool.execute(
          Sql.named(
            '''
              SELECT user_id
              FROM chat.conversation_members
              WHERE conversation_id = @conversation_id
            '''
                .trim(),
          ),
          parameters: {'conversation_id': conversationId},
        );

        return result.mapAll((row) => row.cellId('user_id'));
      });

  @override
  Future<List<Map<String, Object?>>> listMessages({
    required String conversationId,
    required int limit,
    DateTime? before,
  }) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
              SELECT id, sender_id, text, created_at
              FROM chat.messages
              WHERE conversation_id = @conversation_id
              AND (@before IS NULL OR created_at < @before)
              ORDER BY created_at DESC
              LIMIT @limit
            '''
            .trim(),
      ),
      parameters: {
        'conversation_id': conversationId,
        'before': before,
        'limit': limit,
      },
    );

    return result.mapAll((row) => row.columns);
  });

  @override
  Future<DateTime?> findCreatedAtByMessageId({
    required String conversationId,
    required String messageId,
  }) => guarded(() async {
    final result = await pool.execute(
      Sql.named(
        '''
              SELECT created_at
              FROM chat.messages
              WHERE id = @message_id
              AND conversation_id = @conversation_id
              LIMIT 1
            '''
            .trim(),
      ),
      parameters: {'message_id': messageId, 'conversation_id': conversationId},
    );

    return result.mapFirstOrNull(
      (row) => row.columns['created_at'] as DateTime,
    );
  });
}
