import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response_dto.g.dart';
part 'register_response_dto.freezed.dart';

@freezed
abstract class RegisterResponseDto with _$RegisterResponseDto {
  const factory RegisterResponseDto({
    required String id,
    required String email,
    required String username,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _RegisterResponseDto;

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);
}
