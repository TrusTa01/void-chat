import 'package:backend/src/features/auth/login/api/dto/response/login_response_dto.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';

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
