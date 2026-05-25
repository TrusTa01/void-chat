import 'dart:convert';

import 'package:backend/src/features/chat/shared/ws/ws_outbound.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void sendToChannel(WebSocketChannel channel, WsOutbound event) {
  channel.sink.add(jsonEncode(event.toJson()));
}
