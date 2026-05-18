import 'package:backend/src/features/auth/register/complete_profile/api/dto/response/register_response_dto.dart';
import 'package:backend/src/features/auth/domain/entities/user_entity.dart';

extension RegisterResponseMapper on UserEntity {
  RegisterResponseDto toRegisterResponse() {
    return RegisterResponseDto(
      id: id,
      email: email,
      username: username,
      displayName: displayName,
      createdAt: createdAt,
    );
  }
}
