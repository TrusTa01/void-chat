import 'package:backend/src/features/auth/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/login/api/dto/response/login_response_dto.dart';

extension LoginInUserDtoMapper on UserEntity {
  LoggedInUserDto toLoggedInUserDto() {
    return LoggedInUserDto(
      id: id,
      email: email,
      username: username,
      displayName: displayName,
      createdAt: createdAt,
    );
  }
}
