// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteProfileRequestDto _$CompleteProfileRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CompleteProfileRequestDto(
  registrationId: json['registration_id'] as String,
  username: json['username'] as String,
  displayName: json['display_name'] as String,
);

Map<String, dynamic> _$CompleteProfileRequestDtoToJson(
  _CompleteProfileRequestDto instance,
) => <String, dynamic>{
  'registration_id': instance.registrationId,
  'username': instance.username,
  'display_name': instance.displayName,
};
