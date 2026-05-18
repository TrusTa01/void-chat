import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_registration_email_response_dto.freezed.dart';
part 'verify_registration_email_response_dto.g.dart';

@freezed
abstract class VerifyRegistrationEmailResponseDto
    with _$VerifyRegistrationEmailResponseDto {
  const factory VerifyRegistrationEmailResponseDto({required bool verified}) =
      _VerifyRegistrationEmailResponseDto;

  factory VerifyRegistrationEmailResponseDto.fromJson(
    Map<String, dynamic> json,
  ) => _$VerifyRegistrationEmailResponseDtoFromJson(json);
}
