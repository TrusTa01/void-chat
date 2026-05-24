import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_code_request_dto.freezed.dart';
part 'login_code_request_dto.g.dart';

@freezed
abstract class LoginCodeRequestDto with _$LoginCodeRequestDto {
  const factory LoginCodeRequestDto({required String identifier}) =
      _LoginCodeRequestDto;

  factory LoginCodeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginCodeRequestDtoFromJson(json);
}
