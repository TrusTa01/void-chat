import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_profile_request_dto.freezed.dart';
part 'complete_profile_request_dto.g.dart';

@freezed
abstract class CompleteProfileRequestDto with _$CompleteProfileRequestDto {
  const factory CompleteProfileRequestDto({
    @JsonKey(name: 'registration_id') required String registrationId,
    required String username,
    @JsonKey(name: 'display_name') required String displayName,
  }) = _CompleteProfileRequestDto;

  factory CompleteProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestDtoFromJson(json);
}
