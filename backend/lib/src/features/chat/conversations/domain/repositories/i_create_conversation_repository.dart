abstract interface class ICreateConversationRepository {
  Future<String> create({
    required String creatorId,
    required List<String> participantIds,
  });
  Future<String?> findDirectConversation({
    required String userA,
    required String userB,
  });
}
