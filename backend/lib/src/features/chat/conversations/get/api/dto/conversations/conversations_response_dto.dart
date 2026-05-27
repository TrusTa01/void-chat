import 'package:backend/src/features/chat/conversations/get/api/dto/message/message_dto.dart';
import 'package:backend/src/features/chat/conversations/get/api/dto/partner/conversation_partner_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversations_response_dto.freezed.dart';
part 'conversations_response_dto.g.dart';

@freezed
abstract class ConversationsResponseDto with _$ConversationsResponseDto {
  const factory ConversationsResponseDto({
    required List<ConversationsItemDto> conversations,
  }) = _ConversationsResponseDto;

  factory ConversationsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseDtoFromJson(json);
}

@freezed
abstract class ConversationsItemDto with _$ConversationsItemDto {
  const factory ConversationsItemDto({
    required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required ConversationPartnerDto partner,
    @JsonKey(name: 'last_message') MessageDto? lastMessage,
  }) = _ConversationsItemDto;

  factory ConversationsItemDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationsItemDtoFromJson(json);
}
