import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/register_request_dto.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';

extension RegisterRequestMapper on RegisterRequestDto {
  NewUser toNewUser() {
    return NewUser.validate(
      login: login,
      password: password,
      email: email,
      username: username,
      displayName: displayName,
    );
  }
}
