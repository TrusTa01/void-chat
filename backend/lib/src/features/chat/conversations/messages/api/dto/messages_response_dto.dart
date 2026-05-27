import 'package:backend/src/features/chat/conversations/get/api/dto/message/message_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_response_dto.freezed.dart';
part 'messages_response_dto.g.dart';

@freezed
abstract class MessagesResponseDto with _$MessagesResponseDto {
  const factory MessagesResponseDto({
    required List<MessageDto> messages,
    @JsonKey(name: 'has_more') required bool hasMore,
    @JsonKey(name: 'next_before') DateTime? nextBefore,
  }) = _MessagesResponseDto;

  factory MessagesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseDtoFromJson(json);
}
