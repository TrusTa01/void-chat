// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessagesResponseDto _$MessagesResponseDtoFromJson(Map<String, dynamic> json) =>
    _MessagesResponseDto(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['has_more'] as bool,
      nextBefore: json['next_before'] == null
          ? null
          : DateTime.parse(json['next_before'] as String),
    );

Map<String, dynamic> _$MessagesResponseDtoToJson(
  _MessagesResponseDto instance,
) => <String, dynamic>{
  'messages': instance.messages,
  'has_more': instance.hasMore,
  'next_before': instance.nextBefore?.toIso8601String(),
};
