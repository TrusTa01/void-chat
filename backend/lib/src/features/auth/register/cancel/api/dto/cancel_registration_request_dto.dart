import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_registration_request_dto.freezed.dart';
part 'cancel_registration_request_dto.g.dart';

@freezed
abstract class CancelRegistrationRequestDto
    with _$CancelRegistrationRequestDto {
  const factory CancelRegistrationRequestDto({
    @JsonKey(name: 'registration_id') required String registrationId,
  }) = _CancelRegistrationRequestDto;

  factory CancelRegistrationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CancelRegistrationRequestDtoFromJson(json);
}
