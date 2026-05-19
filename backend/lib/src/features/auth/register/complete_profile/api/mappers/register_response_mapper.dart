import 'package:backend/src/features/auth/register/complete_profile/api/dto/response/complete_profile_register_response_dto.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';

extension RegisterResponseMapper on UserEntity {
  CompleteProfileRegisterResponseDto toResponse() {
    return CompleteProfileRegisterResponseDto(
      id: id,
      email: email,
      username: username,
      displayName: displayName,
      createdAt: createdAt,
    );
  }
}
