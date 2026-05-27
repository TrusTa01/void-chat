import 'package:backend/src/features/chat/conversations/get/domain/entities/conversation_entity.dart';

abstract interface class IListConversationsRepository {
  Future<List<ConversationItemEntity>> getList(String userId);
}
