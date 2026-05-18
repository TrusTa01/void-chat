import 'package:backend/src/features/auth/register/start/api/dto/response/start_registration_response_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';

extension StartRegistrationResponseMapper on PendingRegistration {
  StartRegistrationResponseDto toResponse() =>
      StartRegistrationResponseDto(registrationId: registrationId);
}
