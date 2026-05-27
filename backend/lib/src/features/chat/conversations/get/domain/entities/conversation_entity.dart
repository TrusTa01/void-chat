import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_partner_entity.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/message_entity.dart';

final class ConversationsEntity {
  final List<ConversationItemEntity> conversations;

  const ConversationsEntity({required this.conversations});
}

final class ConversationItemEntity {
  final String id;
  final DateTime createdAt;
  final ConversationPartnerEntity partner;
  final MessageEntity? lastMessage;

  const ConversationItemEntity({
    required this.id,
    required this.createdAt,
    required this.partner,
    this.lastMessage,
  });
}
