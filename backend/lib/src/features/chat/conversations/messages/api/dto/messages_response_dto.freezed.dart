// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessagesResponseDto {

 List<MessageDto> get messages;@JsonKey(name: 'has_more') bool get hasMore;@JsonKey(name: 'next_before') DateTime? get nextBefore;
/// Create a copy of MessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesResponseDtoCopyWith<MessagesResponseDto> get copyWith => _$MessagesResponseDtoCopyWithImpl<MessagesResponseDto>(this as MessagesResponseDto, _$identity);

  /// Serializes this MessagesResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesResponseDto&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextBefore, nextBefore) || other.nextBefore == nextBefore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),hasMore,nextBefore);

@override
String toString() {
  return 'MessagesResponseDto(messages: $messages, hasMore: $hasMore, nextBefore: $nextBefore)';
}


}

/// @nodoc
abstract mixin class $MessagesResponseDtoCopyWith<$Res>  {
  factory $MessagesResponseDtoCopyWith(MessagesResponseDto value, $Res Function(MessagesResponseDto) _then) = _$MessagesResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<MessageDto> messages,@JsonKey(name: 'has_more') bool hasMore,@JsonKey(name: 'next_before') DateTime? nextBefore
});




}
/// @nodoc
class _$MessagesResponseDtoCopyWithImpl<$Res>
    implements $MessagesResponseDtoCopyWith<$Res> {
  _$MessagesResponseDtoCopyWithImpl(this._self, this._then);

  final MessagesResponseDto _self;
  final $Res Function(MessagesResponseDto) _then;

/// Create a copy of MessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? hasMore = null,Object? nextBefore = freezed,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextBefore: freezed == nextBefore ? _self.nextBefore : nextBefore // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagesResponseDto].
extension MessagesResponseDtoPatterns on MessagesResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagesResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagesResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagesResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _MessagesResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagesResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _MessagesResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MessageDto> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_before')  DateTime? nextBefore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagesResponseDto() when $default != null:
return $default(_that.messages,_that.hasMore,_that.nextBefore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MessageDto> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_before')  DateTime? nextBefore)  $default,) {final _that = this;
switch (_that) {
case _MessagesResponseDto():
return $default(_that.messages,_that.hasMore,_that.nextBefore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MessageDto> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_before')  DateTime? nextBefore)?  $default,) {final _that = this;
switch (_that) {
case _MessagesResponseDto() when $default != null:
return $default(_that.messages,_that.hasMore,_that.nextBefore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagesResponseDto implements MessagesResponseDto {
  const _MessagesResponseDto({required final  List<MessageDto> messages, @JsonKey(name: 'has_more') required this.hasMore, @JsonKey(name: 'next_before') this.nextBefore}): _messages = messages;
  factory _MessagesResponseDto.fromJson(Map<String, dynamic> json) => _$MessagesResponseDtoFromJson(json);

 final  List<MessageDto> _messages;
@override List<MessageDto> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey(name: 'has_more') final  bool hasMore;
@override@JsonKey(name: 'next_before') final  DateTime? nextBefore;

/// Create a copy of MessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesResponseDtoCopyWith<_MessagesResponseDto> get copyWith => __$MessagesResponseDtoCopyWithImpl<_MessagesResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagesResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesResponseDto&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextBefore, nextBefore) || other.nextBefore == nextBefore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,nextBefore);

@override
String toString() {
  return 'MessagesResponseDto(messages: $messages, hasMore: $hasMore, nextBefore: $nextBefore)';
}


}

/// @nodoc
abstract mixin class _$MessagesResponseDtoCopyWith<$Res> implements $MessagesResponseDtoCopyWith<$Res> {
  factory _$MessagesResponseDtoCopyWith(_MessagesResponseDto value, $Res Function(_MessagesResponseDto) _then) = __$MessagesResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<MessageDto> messages,@JsonKey(name: 'has_more') bool hasMore,@JsonKey(name: 'next_before') DateTime? nextBefore
});




}
/// @nodoc
class __$MessagesResponseDtoCopyWithImpl<$Res>
    implements _$MessagesResponseDtoCopyWith<$Res> {
  __$MessagesResponseDtoCopyWithImpl(this._self, this._then);

  final _MessagesResponseDto _self;
  final $Res Function(_MessagesResponseDto) _then;

/// Create a copy of MessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,Object? nextBefore = freezed,}) {
  return _then(_MessagesResponseDto(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextBefore: freezed == nextBefore ? _self.nextBefore : nextBefore // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
