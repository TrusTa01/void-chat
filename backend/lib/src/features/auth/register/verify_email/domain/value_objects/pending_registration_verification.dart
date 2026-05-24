final class PendingRegistrationVerification {
  final String id;
  final String codeHash;
  final DateTime expiresAt;
  final DateTime? verifiedAt;
  final int attempts;

  const PendingRegistrationVerification({
    required this.id,
    required this.codeHash,
    required this.expiresAt,
    required this.verifiedAt,
    required this.attempts,
  });
}
