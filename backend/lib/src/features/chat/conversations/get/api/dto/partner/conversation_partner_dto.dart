import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_partner_dto.freezed.dart';
part 'conversation_partner_dto.g.dart';

@freezed
abstract class ConversationPartnerDto with _$ConversationPartnerDto {
  const factory ConversationPartnerDto({
    required String id,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ConversationPartnerDto;

  factory ConversationPartnerDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationPartnerDtoFromJson(json);
}
