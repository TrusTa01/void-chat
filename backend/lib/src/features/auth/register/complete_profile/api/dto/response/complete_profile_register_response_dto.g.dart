// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_register_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteProfileRegisterResponseDto
_$CompleteProfileRegisterResponseDtoFromJson(Map<String, dynamic> json) =>
    _CompleteProfileRegisterResponseDto(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CompleteProfileRegisterResponseDtoToJson(
  _CompleteProfileRegisterResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'display_name': instance.displayName,
  'created_at': instance.createdAt.toIso8601String(),
};
