sealed class WsOutbound {
  const WsOutbound();

  Map<String, dynamic> toJson();
}

final class WsConnected extends WsOutbound {
  final String userId;

  const WsConnected({required this.userId});

  @override
  Map<String, dynamic> toJson() => {'event': 'connected', 'user_id': userId};
}

final class WsPong extends WsOutbound {
  const WsPong();

  @override
  Map<String, dynamic> toJson() => {'event': 'pong'};
}

final class WsError extends WsOutbound {
  final String message;

  const WsError(this.message);

  @override
  Map<String, dynamic> toJson() => {'event': 'error', 'message': message};
}

final class WsMessage extends WsOutbound {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final String createdAt;
  const WsMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory WsMessage.fromRow(Map<String, Object?> row) => WsMessage(
    id: row['id'].toString(),
    conversationId: row['conversation_id'].toString(),
    senderId: row['sender_id'].toString(),
    text: row['text'] as String,
    createdAt: row['created_at'].toString(),
  );
  
  @override
  Map<String, dynamic> toJson() => {
    'event': 'message',
    'id': id,
    'conversation_id': conversationId,
    'sender_id': senderId,
    'text': text,
    'created_at': createdAt,
  };
}
