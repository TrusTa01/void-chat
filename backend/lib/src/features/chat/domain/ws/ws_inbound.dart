sealed class WsInbound {
  const WsInbound();
}

final class WsPing extends WsInbound {
  const WsPing();
}

final class WsSendMessage extends WsInbound {
  final String conversationId;
  final String text;

  const WsSendMessage({required this.conversationId, required this.text});
}

WsInbound? parseInbound(Map<String, dynamic> map) => switch (map['event']) {
  'ping' => WsPing(),
  'send_message' => WsSendMessage(
    conversationId: map['conversation_id'] as String? ?? '',
    text: map['text'] as String? ?? '',
  ),
  _ => null,
};
