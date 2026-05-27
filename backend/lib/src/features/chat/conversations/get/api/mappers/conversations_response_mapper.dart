import 'package:backend/src/features/chat/conversations/get/api/dto/conversations/conversations_response_dto.dart';
import 'package:backend/src/features/chat/conversations/get/api/dto/message/message_dto.dart';
import 'package:backend/src/features/chat/conversations/get/api/dto/partner/conversation_partner_dto.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_entity.dart';

extension ConversationsResponseMapper on ConversationsEntity {
  ConversationsResponseDto toDto() => ConversationsResponseDto(
    conversations: conversations
        .map(
          (c) => ConversationsItemDto(
            id: c.id,
            createdAt: c.createdAt,
            partner: ConversationPartnerDto(
              id: c.partner.id,
              displayName: c.partner.displayName,
              avatarUrl: c.partner.avatarUrl,
            ),
            lastMessage: c.lastMessage == null
                ? null
                : MessageDto(
                    id: c.lastMessage!.id,
                    senderId: c.lastMessage!.senderId,
                    text: c.lastMessage!.text,
                    createdAt: c.lastMessage!.createdAt,
                  ),
          ),
        )
        .toList(growable: false),
  );
}
