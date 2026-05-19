import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_code_verify_dto.freezed.dart';
part 'login_code_verify_dto.g.dart';

@freezed
abstract class LoginCodeVerifyDto with _$LoginCodeVerifyDto {
  const factory LoginCodeVerifyDto({
    required String identifier,
    required String code,
  }) = _LoginCodeVerifyDto;

  factory LoginCodeVerifyDto.fromJson(Map<String, dynamic> json) =>
      _$LoginCodeVerifyDtoFromJson(json);
}
