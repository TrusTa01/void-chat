import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_conversation_dto.freezed.dart';
part 'create_conversation_dto.g.dart';

@freezed
abstract class CreateConversationRequestDto
    with _$CreateConversationRequestDto {
  const factory CreateConversationRequestDto({
    required List<String> participantIds,
  }) = _CreateConversationRequestDto;

  factory CreateConversationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationRequestDtoFromJson(json);
}