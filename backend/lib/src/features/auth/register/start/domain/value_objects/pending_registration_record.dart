final class PendingRegistrationRecord {
  final String login;
  final String email;
  final String passwordHash;
  final String codeHash;
  final DateTime expiresAt;

  const PendingRegistrationRecord({
    required this.login,
    required this.email,
    required this.passwordHash,
    required this.codeHash,
    required this.expiresAt,
  });
}
