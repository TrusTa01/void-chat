import 'dart:convert';

import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/api/parse_body.dart';
import 'package:backend/src/features/chat/conversations/get/api/mappers/conversations_response_mapper.dart';
import 'package:backend/src/features/chat/conversations/get/domain/use_cases/list_conversations_use_case.dart';
import 'package:backend/src/features/chat/conversations/messages/api/mappers/messages_response_mapper.dart';
import 'package:backend/src/features/chat/conversations/messages/domain/use_cases/list_messages_use_case.dart';
import 'package:backend/src/features/chat/conversations/create/api/dto/create/create_conversation_dto.dart';
import 'package:backend/src/features/chat/conversations/create/domain/use_cases/create_conversations_use_case.dart';
import 'package:backend/src/features/chat/messages/domain/usecases/user_id_use_case.dart';
import 'package:backend/src/features/chat/shared/ws/chat_connection_registry.dart';
import 'package:backend/src/features/chat/shared/ws/ws_channel_sender.dart';
import 'package:backend/src/features/chat/shared/ws/ws_inbound.dart';
import 'package:backend/src/features/chat/shared/ws/ws_outbound.dart';
import 'package:backend/src/features/chat/messages/domain/ws/ws_send_message_handler.dart';
import 'package:backend/src/features/chat/shared/chat_error_messages.dart';
import 'package:backend/src/middleware/auth_middleware.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@lazySingleton
class ChatApi {
  final ChatConnectionRegistry _connections;
  final IUserIdUseCase _userIdUseCase;
  final WsSendMessageHandler _messageHandler;
  final ICreateConversationUseCase _createConversationUseCase;
  final IListConversationsUseCase _listConversationsUseCase;
  final IListMessagesUseCase _listMessagesUseCase;

  ChatApi(
    this._connections,
    this._userIdUseCase,
    this._messageHandler,
    this._createConversationUseCase,
    this._listConversationsUseCase,
    this._listMessagesUseCase,
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

    r.post(
      '/conversations/create',
      (Request request) => _handleCreateConversation(request),
    );

    r.get(
      '/conversations',
      (Request request) => _handleListConversation(request),
    );

    r.get(
      '/conversations/<id>/messages',
      (Request request) => _handleMessages(request),
    );

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

      sendToChannel(channel, WsConnected(userId: userId));
      _connections.add(userId, channel);
      talker.info('WS connected: userId=$userId');

      channel.stream.listen((raw) async {
        try {
          final map = jsonDecode(raw as String) as Map<String, dynamic>;
          final inbound = parseInbound(map);

          if (inbound == null) {
            sendToChannel(
              channel,
              WsError(
                code: '${ChatErrorMessages.unknownEvent} ${map['event']}',
                message: 'Unknown event',
              ),
            );
            return;
          }
          talker.info('WS in: event=$inbound userId=$userId');

          switch (inbound) {
            case WsPing():
              sendToChannel(channel, WsPong());

            case WsSendMessage(:final conversationId, :final text):
              await _messageHandler.handle(
                userId: userId,
                channel: channel,
                conversationId: conversationId,
                text: text,
              );
          }
        } catch (_) {
          sendToChannel(
            channel,
            WsError(code: ChatErrorMessages.badJson, message: 'Bad JSON'),
          );
        }
      }, onDone: () => _connections.remove(userId));
    });
  }

  Future<Response> _handleCreateConversation(Request request) async {
    final creatorId = request.context[authenticatedUserIdKey] as String;
    final body = await request.readAsString();
    final dto = parseBody(body, CreateConversationRequestDto.fromJson);
    final conversationId = await _createConversationUseCase.call(
      creatorId: creatorId,
      participantIds: dto.participantIds,
    );
    return JsonResponse.created({'conversation_id': conversationId});
  }

  Future<Response> _handleListConversation(Request request) async {
    final userId = request.context[authenticatedUserIdKey] as String;
    final entity = await _listConversationsUseCase.call(userId);
    return JsonResponse.ok(entity.toDto().toJson());
  }

  Future<Response> _handleMessages(Request request) async {
    final userId = request.context[authenticatedUserIdKey] as String;
    final conversationId = request.params['id']!;

    final rawLimit = int.tryParse(request.url.queryParameters['limit'] ?? '');
    final limit = (rawLimit ?? 50).clamp(1, 100);
    final before = request.url.queryParameters['before'];

    final entity = await _listMessagesUseCase.call(
      userId: userId,
      conversationId: conversationId,
      limit: limit,
      before: before,
    );

    return JsonResponse.ok(entity.toDto().toJson());
  }
}
