import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/chat/conversations/get/domain/entities/message_entity.dart';
import 'package:backend/src/features/chat/conversations/messages/domain/entities/messages_list_entity.dart';
import 'package:backend/src/features/chat/messages/domain/repositories/i_message_repository.dart';
import 'package:backend/src/features/chat/shared/chat_error_messages.dart';
import 'package:injectable/injectable.dart';

abstract interface class IListMessagesUseCase {
  Future<MessagesListEntity> call({
    required String userId,
    required String conversationId,
    required int limit,
    String? before,
  });
}

@LazySingleton(as: IListMessagesUseCase)
class ListMessagesUseCaseImpl implements IListMessagesUseCase {
  static final _uuidPattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  final IMessageRepository _messageRepository;

  const ListMessagesUseCaseImpl(this._messageRepository);

  @override
  Future<MessagesListEntity> call({
    required String userId,
    required String conversationId,
    required int limit,
    String? before,
  }) async {
    final trimmedConversationId = conversationId.trim();
    if (trimmedConversationId.isEmpty) {
      throw const ValidationException(
        'INVALID_CONVERSATION_ID',
        'conversation id required',
      );
    }

    final isMember = await _messageRepository.isMember(
      conversationId: trimmedConversationId,
      userId: userId,
    );
    if (!isMember) {
      throw const ForbiddenException(
        ChatErrorMessages.notAMember,
        'Not a member',
      );
    }

    final beforeCreatedAt = await _resolveBefore(
      conversationId: trimmedConversationId,
      before: before?.trim(),
    );

    final rows = await _messageRepository.listMessages(
      conversationId: trimmedConversationId,
      limit: limit + 1,
      before: beforeCreatedAt,
    );

    final hasMore = rows.length > limit;
    final page = hasMore ? rows.sublist(0, limit) : rows;

    final messages = page
        .map(
          (row) => MessageEntity(
            id: row['id'].toString(),
            senderId: row['sender_id'].toString(),
            text: row['text'] as String,
            createdAt: row['created_at'] as DateTime,
          ),
        )
        .toList(growable: false);

    // DB returns newest-first; client expects oldest-first in the batch.
    final chronological = messages.reversed.toList(growable: false);

    final nextBefore = chronological.isEmpty
        ? null
        : chronological.first.createdAt;

    return MessagesListEntity(
      messages: chronological,
      hasMore: hasMore,
      nextBefore: nextBefore,
    );
  }

  Future<DateTime?> _resolveBefore({
    required String conversationId,
    required String? before,
  }) async {
    if (before == null || before.isEmpty) return null;

    if (_uuidPattern.hasMatch(before)) {
      final createdAt = await _messageRepository.findCreatedAtByMessageId(
        conversationId: conversationId,
        messageId: before,
      );
      if (createdAt == null) {
        throw const ValidationException(
          'INVALID_BEFORE',
          'Message not found for before cursor',
        );
      }
      return createdAt;
    }

    final parsed = DateTime.tryParse(before);
    if (parsed == null) {
      throw const ValidationException(
        'INVALID_BEFORE',
        'before must be ISO-8601 timestamp or message id',
      );
    }
    return parsed.toUtc();
  }
}
