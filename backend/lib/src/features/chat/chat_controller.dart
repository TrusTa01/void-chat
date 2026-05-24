import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/chat/domain/repositories/i_message_repository.dart';
import 'package:backend/src/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:backend/src/features/chat/domain/usecases/user_id_use_case.dart';
import 'package:backend/src/features/chat/domain/value_objects/send_message_result.dart';
import 'package:backend/src/features/chat/domain/ws/chat_connection_registry.dart';
import 'package:backend/src/features/chat/domain/ws/ws_inbound.dart';
import 'package:backend/src/features/chat/domain/ws/ws_outbound.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@lazySingleton
class ChatApi {
  final IUserIdUseCase _userIdUseCase;
  final ChatConnectionRegistry _connections;
  final ISendMessageUseCase _sendMessageUseCase;
  final IMessageRepository _messageRepository;

  ChatApi(
    this._userIdUseCase,
    this._connections,
    this._sendMessageUseCase,
    this._messageRepository,
  );

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    r.get('/ws', (Request request) {
      final token = request.url.queryParameters['token'];
      return webSocketHandler((channel, _) {
        _handleWebSocket(channel, token);
      })(request);
    });

    return r;
  }

  void _handleWebSocket(WebSocketChannel channel, String? token) {
    if (token == null || token.isEmpty) {
      channel.sink.close();
      return;
    }

    _userIdUseCase.call(token).then((userId) {
      if (userId == null) {
        channel.sink.close();
        return;
      }

      _send(channel, WsConnected(userId: userId));
      _connections.add(userId, channel);
      talker.info('WS connected: userId=$userId');

      channel.stream.listen((raw) async {
        try {
          final map = jsonDecode(raw as String) as Map<String, dynamic>;
          final inbound = parseInbound(map);

          if (inbound == null) {
            _send(channel, WsError('Unknown event: ${map['event']}'));
            return;
          }
          talker.info('WS in: event=$inbound userId=$userId');

          switch (inbound) {
            case WsPing():
              _send(channel, WsPong());

            case WsSendMessage(:final conversationId, :final text):
              await _handleSendMessage(
                userId: userId,
                channel: channel,
                conversationId: conversationId,
                text: text,
              );
          }
        } catch (_) {
          _send(channel, WsError('Bad JSON'));
        }
      }, onDone: () => _connections.remove(userId));
    });
  }

  void _send(WebSocketChannel channel, WsOutbound event) =>
      channel.sink.add(jsonEncode(event.toJson()));

  Future<void> _handleSendMessage({
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
        _send(channel, const WsError('conversation_id and text required'));
      case NotAMember():
        _send(channel, const WsError('Not a member'));
      case SendMessageSuccess(:final message):
        await _broadcastMessage(userId: userId, row: message);
    }
  }

  Future<void> _broadcastMessage({
    required String userId,
    required Map<String, Object?> row,
  }) async {
    final event = WsMessage.fromRow(row);
    final conversationId = event.conversationId;

    final senderChannel = _connections.get(userId);
    if (senderChannel != null) {
      _send(senderChannel, event);
    }

    final members = await _messageRepository.listMemberIds(conversationId);
    for (final memberId in members) {
      if (memberId == userId) continue;
      final ch = _connections.get(memberId);
      if (ch != null) _send(ch, event);
    }
    talker.info('WS message saved: id=${event.id}');
  }
}
