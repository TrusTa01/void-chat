import 'package:backend/src/features/chat/messages/domain/repositories/i_message_repository.dart';
import 'package:backend/src/features/chat/messages/domain/value_objects/send_message_result.dart';
import 'package:injectable/injectable.dart';

abstract interface class ISendMessageUseCase {
  Future<SendMessageResult> call({
    required String senderId,
    required String conversationId,
    required String text,
  });
}

@LazySingleton(as: ISendMessageUseCase)
class SendMessageUseCaseImpl implements ISendMessageUseCase {
  final IMessageRepository _messageRepository;

  const SendMessageUseCaseImpl(this._messageRepository);

  @override
  Future<SendMessageResult> call({
    required String senderId,
    required String conversationId,
    required String text,
  }) async {
    final trimmedConversationId = conversationId.trim();
    final trimmedText = text.trim();

    if (trimmedConversationId.isEmpty || trimmedText.isEmpty) {
      return const InvalidSendMessageInput();
    }

    final allowed = await _messageRepository.isMember(
      conversationId: trimmedConversationId,
      userId: senderId,
    );

    if (!allowed) return const NotAMember();

    final row = await _messageRepository.insert(
      conversationId: trimmedConversationId,
      senderId: senderId,
      text: trimmedText,
    );

    return SendMessageSuccess(row);
  }
}
