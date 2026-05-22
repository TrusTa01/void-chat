import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_registration_response_dto.freezed.dart';
part 'start_registration_response_dto.g.dart';

@freezed
abstract class StartRegistrationResponseDto with _$StartRegistrationResponseDto {
  const factory StartRegistrationResponseDto({
    @JsonKey(name: 'registration_id') required String registrationId,
  }) = _StartRegistrationResponseDto;

  factory StartRegistrationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StartRegistrationResponseDtoFromJson(json);
}
