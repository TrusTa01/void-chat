import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';

class LoginResult {
  final String token;
  final UserEntity user;

  const LoginResult({required this.token, required this.user});
}
