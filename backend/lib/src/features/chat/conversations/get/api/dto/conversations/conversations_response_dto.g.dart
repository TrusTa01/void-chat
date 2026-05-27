// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationsResponseDto _$ConversationsResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationsResponseDto(
  conversations: (json['conversations'] as List<dynamic>)
      .map((e) => ConversationsItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ConversationsResponseDtoToJson(
  _ConversationsResponseDto instance,
) => <String, dynamic>{'conversations': instance.conversations};

_ConversationsItemDto _$ConversationsItemDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationsItemDto(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  partner: ConversationPartnerDto.fromJson(
    json['partner'] as Map<String, dynamic>,
  ),
  lastMessage: json['last_message'] == null
      ? null
      : MessageDto.fromJson(json['last_message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConversationsItemDtoToJson(
  _ConversationsItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'partner': instance.partner,
  'last_message': instance.lastMessage,
};
