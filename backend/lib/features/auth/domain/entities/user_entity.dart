final class UserEntity {
  final int id;
  final String email;
  final String username;
  final String displayName;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    required this.createdAt,
  });
}
