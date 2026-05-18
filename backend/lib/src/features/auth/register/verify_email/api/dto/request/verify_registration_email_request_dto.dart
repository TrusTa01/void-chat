import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_registration_email_request_dto.freezed.dart';
part 'verify_registration_email_request_dto.g.dart';

@freezed
abstract class VerifyRegistrationEmailRequestDto
    with _$VerifyRegistrationEmailRequestDto {
  const factory VerifyRegistrationEmailRequestDto({
    @JsonKey(name: 'registration_id') required String registrationId,
    required String code,
  }) = _VerifyRegistrationEmailRequestDto;

  factory VerifyRegistrationEmailRequestDto.fromJson(
    Map<String, dynamic> json,
  ) => _$VerifyRegistrationEmailRequestDtoFromJson(json);
}
