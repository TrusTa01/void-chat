/// Raw user with plain pass
final class NewUser {
  final String login;
  final String password; // plain
  final String email;
  final String username;
  final String displayName;

  const NewUser({
    required this.login,
    required this.password,
    required this.email,
    required this.username,
    required this.displayName,
  });
}

/// Ready to write to a db
final class NewUserRecord {
  final String login;
  final String passwordHash; // hash
  final String email;
  final String username;
  final String displayName;

  const NewUserRecord({
    required this.login,
    required this.passwordHash,
    required this.email,
    required this.username,
    required this.displayName,
  });
}
