// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_registration_email_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyRegistrationEmailRequestDto _$VerifyRegistrationEmailRequestDtoFromJson(
  Map<String, dynamic> json,
) => _VerifyRegistrationEmailRequestDto(
  registrationId: json['registration_id'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$VerifyRegistrationEmailRequestDtoToJson(
  _VerifyRegistrationEmailRequestDto instance,
) => <String, dynamic>{
  'registration_id': instance.registrationId,
  'code': instance.code,
};
