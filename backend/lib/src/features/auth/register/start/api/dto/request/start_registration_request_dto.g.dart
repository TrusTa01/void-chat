// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_registration_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartRegistrationRequestDto _$StartRegistrationRequestDtoFromJson(
  Map<String, dynamic> json,
) => _StartRegistrationRequestDto(
  login: json['login'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$StartRegistrationRequestDtoToJson(
  _StartRegistrationRequestDto instance,
) => <String, dynamic>{
  'login': instance.login,
  'email': instance.email,
  'password': instance.password,
};
