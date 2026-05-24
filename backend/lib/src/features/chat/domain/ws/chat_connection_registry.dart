import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@lazySingleton
class ChatConnectionRegistry {
  final Map<String, WebSocketChannel> _online = {};

  void add(String userId, WebSocketChannel channel) =>
      _online[userId] = channel;

  void remove(String userId) => _online.remove(userId);

  WebSocketChannel? get(String userId) => _online[userId];
}
