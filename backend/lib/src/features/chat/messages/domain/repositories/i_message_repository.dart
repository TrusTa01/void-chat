abstract interface class IMessageRepository {
  Future<Map<String, Object?>> insert({
    required String conversationId,
    required String senderId,
    required String text,
  });
  Future<bool> isMember({
    required String conversationId,
    required String userId,
  });
  Future<List<String>> listMemberIds(String conversationId);
}
