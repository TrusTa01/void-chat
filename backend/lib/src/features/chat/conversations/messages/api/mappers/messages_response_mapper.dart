import 'package:backend/src/features/chat/conversations/get/api/dto/message/message_dto.dart';
import 'package:backend/src/features/chat/conversations/messages/api/dto/messages_response_dto.dart';
import 'package:backend/src/features/chat/conversations/messages/domain/entities/messages_list_entity.dart';

extension MessagesListResponseMapper on MessagesListEntity {
  MessagesResponseDto toDto() => MessagesResponseDto(
    messages: messages
        .map(
          (m) => MessageDto(
            id: m.id,
            senderId: m.senderId,
            text: m.text,
            createdAt: m.createdAt,
          ),
        )
        .toList(growable: false),
    hasMore: hasMore,
    nextBefore: nextBefore,
  );
}
