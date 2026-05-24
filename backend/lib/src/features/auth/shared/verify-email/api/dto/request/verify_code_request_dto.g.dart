// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CodeVerifyRequestDto _$CodeVerifyRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CodeVerifyRequestDto(
  registrationId: json['registration_id'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$CodeVerifyRequestDtoToJson(
  _CodeVerifyRequestDto instance,
) => <String, dynamic>{
  'registration_id': instance.registrationId,
  'code': instance.code,
};
