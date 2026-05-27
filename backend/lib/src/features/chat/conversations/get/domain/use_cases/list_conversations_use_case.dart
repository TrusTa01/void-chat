import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_entity.dart';
import 'package:backend/src/features/chat/conversations/get/domain/repositories/i_list_conversations_repository.dart';
import 'package:injectable/injectable.dart';

abstract interface class IListConversationsUseCase {
  Future<ConversationsEntity> call(String userId);
}

@LazySingleton(as: IListConversationsUseCase)
class ListConversationsUseCaseImpl implements IListConversationsUseCase {
  final IListConversationsRepository _repository;

  const ListConversationsUseCaseImpl(this._repository);

  @override
  Future<ConversationsEntity> call(String userId) async {
    final conversations = await _repository.getList(userId);
    return ConversationsEntity(conversations: conversations);
  }
}
