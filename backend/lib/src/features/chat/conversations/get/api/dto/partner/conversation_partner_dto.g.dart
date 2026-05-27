// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_partner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationPartnerDto _$ConversationPartnerDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationPartnerDto(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$ConversationPartnerDtoToJson(
  _ConversationPartnerDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'avatar_url': instance.avatarUrl,
};
