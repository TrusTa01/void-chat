import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_response_dto.freezed.dart';
part 'verify_email_response_dto.g.dart';

@freezed
abstract class VerifyEmailResponseDto with _$VerifyEmailResponseDto {
  const factory VerifyEmailResponseDto({required bool verified}) =
      _VerifyEmailResponseDto;

  factory VerifyEmailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseDtoFromJson(json);
}
