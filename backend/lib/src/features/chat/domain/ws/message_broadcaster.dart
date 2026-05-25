import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/chat/domain/repositories/i_message_repository.dart';
import 'package:backend/src/features/chat/domain/ws/chat_connection_registry.dart';
import 'package:backend/src/features/chat/domain/ws/ws_channel_sender.dart';
import 'package:backend/src/features/chat/domain/ws/ws_outbound.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MessageBroadcaster {
  final ChatConnectionRegistry _connections;
  final IMessageRepository _messageRepository;

  const MessageBroadcaster(this._connections, this._messageRepository);

  Future<void> broadcastToConversation({
    required String userId,
    required Map<String, Object?> row,
  }) async {
    final event = WsMessage.fromRow(row);
    final conversationId = event.conversationId;

    final senderChannel = _connections.get(userId);
    if (senderChannel != null) {
      sendToChannel(senderChannel, event);
    }

    final members = await _messageRepository.listMemberIds(conversationId);
    for (final memberId in members) {
      if (memberId == userId) continue;
      final ch = _connections.get(memberId);
      if (ch != null) sendToChannel(ch, event);
    }
    talker.info('WS message saved: id=${event.id}');
  }
}
