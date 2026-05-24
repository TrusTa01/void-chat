// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    _LoginResponseDto(
      accessToken: json['access_token'] as String,
      user: LoggedInUserDto.fromJson(json['user'] as Map<String, dynamic>),
      expiresIn: (json['expires_in'] as num).toInt(),
    );

Map<String, dynamic> _$LoginResponseDtoToJson(_LoginResponseDto instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'user': instance.user,
      'expires_in': instance.expiresIn,
    };

_LoggedInUserDto _$LoggedInUserDtoFromJson(Map<String, dynamic> json) =>
    _LoggedInUserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LoggedInUserDtoToJson(_LoggedInUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'display_name': instance.displayName,
      'created_at': instance.createdAt.toIso8601String(),
    };
