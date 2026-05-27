import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/chat/conversations/create/domain/repositories/i_create_conversation_repository.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICreateConversationUseCase {
  Future<String> call({
    required String creatorId,
    required List<String> participantIds,
  });
}

@LazySingleton(as: ICreateConversationUseCase)
class CreateConversationsUseCase implements ICreateConversationUseCase {
  final IUserRepository _userRepo;
  final ICreateConversationRepository _conversationRepo;

  const CreateConversationsUseCase(this._userRepo, this._conversationRepo);

  @override
  Future<String> call({
    required String creatorId,
    required List<String> participantIds,
  }) async {
    final normalized = participantIds
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .where((e) => e != creatorId)
        .toSet()
        .toList();

    if (normalized.isEmpty) {
      throw const ValidationException(
        'FIELDS_REQUIRED',
        'participantIds required',
      );
    }

    for (final participantId in normalized) {
      final user = await _userRepo.findById(participantId);
      if (user == null) {
        throw NotFoundException(
          'USER_NOT_FOUND',
          'User not found: $participantId',
        );
      }
    }

    if (normalized.length != 1) {
      throw const ValidationException(
        'INVALID_PARTICIPANTS',
        'Direct chat requires exactly one participant',
      );
    }
    final otherUserId = normalized.single;
    final existingId = await _conversationRepo.findDirectConversation(
      userA: creatorId,
      userB: otherUserId,
    );
    if (existingId != null) return existingId;

    return _conversationRepo.create(
      creatorId: creatorId,
      participantIds: normalized,
    );
  }
}
