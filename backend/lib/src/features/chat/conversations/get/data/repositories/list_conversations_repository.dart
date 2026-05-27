import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_entity.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_partner_entity.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/message_entity.dart';
import 'package:backend/src/features/chat/conversations/get/domain/repositories/i_list_conversations_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IListConversationsRepository)
class ListConversationsRepository extends PgRepository
    implements IListConversationsRepository {
  const ListConversationsRepository(super.pool);

  @override
  Future<List<ConversationItemEntity>> getList(String userId) =>
      guarded(() async {
        final result = await pool.execute(
          Sql.named(
            '''
          SELECT c.id AS conversation_id,
          c.created_at AS conversation_created_at,
          p.id AS partner_id,
          p.display_name AS partner_display_name,
          NULL::text AS partner_avatar_url,
          msg.id AS last_message_id,
          msg.sender_id AS last_message_sender_id,
          msg.text AS last_message_text,
          msg.created_at AS last_message_created_at 
          FROM chat.conversation_members me
          JOIN chat.conversations c 
          ON c.id = me.conversation_id 
          JOIN chat.conversation_members partner_members 
          ON partner_members.conversation_id = c.id 
          AND partner_members.user_id <> me.user_id 
          JOIN auth.users p 
          ON p.id = partner_members.user_id 
          LEFT JOIN LATERAL ( 
          SELECT m.* 
          FROM chat.messages m 
          WHERE m.conversation_id = c.id 
          ORDER BY m.created_at DESC 
          LIMIT 1 
          ) msg 
          ON true 
          WHERE me.user_id = @userId 
          ORDER BY COALESCE(msg.created_at, c.created_at) DESC;
        '''
                .trim(),
          ),
          parameters: {'userId': userId},
        );

        return result.mapAll((row) {
          final cols = row.columns;

          final lastMessageId = cols['last_message_id']?.toString();
          final lastMessage = lastMessageId == null
              ? null
              : MessageEntity(
                  id: lastMessageId,
                  senderId: cols['last_message_sender_id'].toString(),
                  text: cols['last_message_text'] as String,
                  createdAt: cols['last_message_created_at'] as DateTime,
                );

          return ConversationItemEntity(
            id: cols['conversation_id'].toString(),
            createdAt: cols['conversation_created_at'] as DateTime,
            partner: ConversationPartnerEntity(
              id: cols['partner_id'].toString(),
              displayName: cols['partner_display_name'] as String,
              avatarUrl: cols['partner_avatar_url'] as String?,
            ),
            lastMessage: lastMessage,
          );
        });
      });
}
