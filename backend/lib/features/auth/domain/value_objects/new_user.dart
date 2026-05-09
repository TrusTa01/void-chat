import 'package:backend/features/auth/domain/validators/new_user_validator.dart';

/// Raw user with plain pass
final class NewUser {
  final String login;
  final String password; // plain
  final String email;
  final String username;
  final String displayName;

  const NewUser._({
    required this.login,
    required this.password,
    required this.email,
    required this.username,
    required this.displayName,
  });

  factory NewUser.validate({
    required String login,
    required String password,
    required String email,
    required String username,
    required String displayName,
  }) {
    final n = validateNewUserInput(
      login: login,
      password: password,
      email: email,
      username: username,
      displayName: displayName,
    );
    return NewUser._(
      login: n.login,
      password: n.password,
      email: n.email,
      username: n.username,
      displayName: n.displayName,
    );
  }
}

/// Ready to be written to a db
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
