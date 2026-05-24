sealed class SendMessageResult {
  const SendMessageResult();
}

class SendMessageSuccess extends SendMessageResult {
  final Map<String, Object?> message;

  const SendMessageSuccess(this.message);
}

class NotAMember extends SendMessageResult {
  const NotAMember();
}

class InvalidSendMessageInput extends SendMessageResult {
  const InvalidSendMessageInput();
}
