import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @JsonKey(name: 'access_token') required String accessToken,
    required LoggedInUserDto user,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

@freezed
abstract class LoggedInUserDto with _$LoggedInUserDto {
  const factory LoggedInUserDto({
    required String id,
    required String email,
    required String username,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LoggedInUserDto;

  factory LoggedInUserDto.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserDtoFromJson(json);
}
