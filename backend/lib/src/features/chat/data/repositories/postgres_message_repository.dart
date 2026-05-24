import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/features/chat/domain/repositories/i_message_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IMessageRepository)
class PostgresMessageRepositoryImpl
    with PgErrorHandling
    implements IMessageRepository {
  final Pool<Connection> _pool;

  PostgresMessageRepositoryImpl(this._pool);

  @override
  Future<Map<String, Object?>> insert({
    required String conversationId,
    required String senderId,
    required String text,
  }) => guarded(() async {
    final result = await _pool.execute(
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
    return result.first.toColumnMap();
  });

  @override
  Future<bool> isMember({
    required String conversationId,
    required String userId,
  }) => guarded(() async {
    final result = await _pool.execute(
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
        final result = await _pool.execute(
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
        return result
            .map((row) => row.toColumnMap()['user_id'].toString())
            .toList();
      });
}
