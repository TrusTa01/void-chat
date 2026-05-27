final class ConversationPartnerEntity {
  final String id;
  final String displayName;
  final String? avatarUrl;

  const ConversationPartnerEntity({
    required this.id,
    required this.displayName,
    this.avatarUrl,
  });
}
