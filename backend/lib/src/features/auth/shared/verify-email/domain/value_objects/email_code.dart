class EmailCode {
  final String id;
  final String codeHash;
  final DateTime expiresAt;
  final int attempts;

  const EmailCode({
    required this.id,
    required this.codeHash,
    required this.expiresAt,
    required this.attempts,
  });
}
