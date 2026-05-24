import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_code_request_dto.freezed.dart';
part 'verify_code_request_dto.g.dart';

@freezed
abstract class CodeVerifyRequestDto with _$CodeVerifyRequestDto {
  const factory CodeVerifyRequestDto({
    @JsonKey(name: 'registration_id') required String registrationId,
    required String code,
  }) = _CodeVerifyRequestDto;

  factory CodeVerifyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CodeVerifyRequestDtoFromJson(json);
}
