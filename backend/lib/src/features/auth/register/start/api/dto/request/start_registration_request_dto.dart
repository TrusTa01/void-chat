import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_registration_request_dto.freezed.dart';
part 'start_registration_request_dto.g.dart';

@freezed
abstract class StartRegistrationRequestDto with _$StartRegistrationRequestDto {
  const factory StartRegistrationRequestDto({
    required String login,
    required String email,
    required String password,
  }) = _StartRegistrationRequestDto;

  factory StartRegistrationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$StartRegistrationRequestDtoFromJson(json);
}
