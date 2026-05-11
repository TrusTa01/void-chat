import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_dto.g.dart';
part 'register_request_dto.freezed.dart';

@freezed
abstract class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String login,
    required String password,
    required String email,
    required String username,
    @JsonKey(name: 'display_name') required String displayName,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);
}
