// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_conversation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateConversationRequestDto _$CreateConversationRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateConversationRequestDto(
  participantIds: (json['participantIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CreateConversationRequestDtoToJson(
  _CreateConversationRequestDto instance,
) => <String, dynamic>{'participantIds': instance.participantIds};
