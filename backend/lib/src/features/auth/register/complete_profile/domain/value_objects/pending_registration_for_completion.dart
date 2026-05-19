final class PendingRegistrationForCompletion {
  final String id;
  final String login;
  final String email;
  final String passwordHash;
  final DateTime? verifiedAt;

  const PendingRegistrationForCompletion({
    required this.id,
    required this.login,
    required this.email,
    required this.passwordHash,
    required this.verifiedAt,
  });
}
