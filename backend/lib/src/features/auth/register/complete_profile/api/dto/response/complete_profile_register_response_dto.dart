import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_profile_register_response_dto.freezed.dart';
part 'complete_profile_register_response_dto.g.dart';

@freezed
abstract class CompleteProfileRegisterResponseDto
    with _$CompleteProfileRegisterResponseDto {
  const factory CompleteProfileRegisterResponseDto({
    required String id,
    required String email,
    required String username,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _CompleteProfileRegisterResponseDto;

  factory CompleteProfileRegisterResponseDto.fromJson(
    Map<String, dynamic> json,
  ) => _$CompleteProfileRegisterResponseDtoFromJson(json);
}
