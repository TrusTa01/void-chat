import 'package:backend/src/features/chat/messages/domain/usecases/send_message_use_case.dart';
import 'package:backend/src/features/chat/messages/domain/value_objects/send_message_result.dart';
import 'package:backend/src/features/chat/messages/domain/ws/message_broadcaster.dart';
import 'package:backend/src/features/chat/shared/ws/ws_channel_sender.dart';
import 'package:backend/src/features/chat/shared/ws/ws_outbound.dart';
import 'package:backend/src/features/chat/shared/chat_error_messages.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@lazySingleton
class WsSendMessageHandler {
  final ISendMessageUseCase _sendMessageUseCase;
  final MessageBroadcaster _messageBroadcaster;

  const WsSendMessageHandler(
    this._sendMessageUseCase,
    this._messageBroadcaster,
  );

  Future<WsOutbound?> handle({
    required String userId,
    required WebSocketChannel channel,
    required String conversationId,
    required String text,
  }) async {
    final result = await _sendMessageUseCase.call(
      senderId: userId,
      conversationId: conversationId,
      text: text,
    );

    switch (result) {
      case InvalidSendMessageInput():
        sendToChannel(
          channel,
          const WsError(
            code: ChatErrorMessages.fieldsRequired,
            message: 'conversation_id and text required',
          ),
        );
      case NotAMember():
        sendToChannel(
          channel,
          const WsError(
            code: ChatErrorMessages.notAMember,
            message: 'Not a member',
          ),
        );
      case SendMessageSuccess(:final message):
        await _messageBroadcaster.broadcastToConversation(
          userId: userId,
          row: message,
        );
    }
    return null;
  }
}
