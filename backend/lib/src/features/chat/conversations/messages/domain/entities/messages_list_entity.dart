import 'package:backend/src/features/chat/conversations/get/domain/entities/message_entity.dart';

final class MessagesListEntity {
  final List<MessageEntity> messages;
  final bool hasMore;
  final DateTime? nextBefore;

  const MessagesListEntity({
    required this.messages,
    required this.hasMore,
    this.nextBefore,
  });
}
