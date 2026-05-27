// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversations_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationsResponseDto {

 List<ConversationsItemDto> get conversations;
/// Create a copy of ConversationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsResponseDtoCopyWith<ConversationsResponseDto> get copyWith => _$ConversationsResponseDtoCopyWithImpl<ConversationsResponseDto>(this as ConversationsResponseDto, _$identity);

  /// Serializes this ConversationsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsResponseDto&&const DeepCollectionEquality().equals(other.conversations, conversations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(conversations));

@override
String toString() {
  return 'ConversationsResponseDto(conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class $ConversationsResponseDtoCopyWith<$Res>  {
  factory $ConversationsResponseDtoCopyWith(ConversationsResponseDto value, $Res Function(ConversationsResponseDto) _then) = _$ConversationsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<ConversationsItemDto> conversations
});




}
/// @nodoc
class _$ConversationsResponseDtoCopyWithImpl<$Res>
    implements $ConversationsResponseDtoCopyWith<$Res> {
  _$ConversationsResponseDtoCopyWithImpl(this._self, this._then);

  final ConversationsResponseDto _self;
  final $Res Function(ConversationsResponseDto) _then;

/// Create a copy of ConversationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversations = null,}) {
  return _then(_self.copyWith(
conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ConversationsItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationsResponseDto].
extension ConversationsResponseDtoPatterns on ConversationsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ConversationsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ConversationsItemDto> conversations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationsResponseDto() when $default != null:
return $default(_that.conversations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ConversationsItemDto> conversations)  $default,) {final _that = this;
switch (_that) {
case _ConversationsResponseDto():
return $default(_that.conversations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ConversationsItemDto> conversations)?  $default,) {final _that = this;
switch (_that) {
case _ConversationsResponseDto() when $default != null:
return $default(_that.conversations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationsResponseDto implements ConversationsResponseDto {
  const _ConversationsResponseDto({required final  List<ConversationsItemDto> conversations}): _conversations = conversations;
  factory _ConversationsResponseDto.fromJson(Map<String, dynamic> json) => _$ConversationsResponseDtoFromJson(json);

 final  List<ConversationsItemDto> _conversations;
@override List<ConversationsItemDto> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}


/// Create a copy of ConversationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationsResponseDtoCopyWith<_ConversationsResponseDto> get copyWith => __$ConversationsResponseDtoCopyWithImpl<_ConversationsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationsResponseDto&&const DeepCollectionEquality().equals(other._conversations, _conversations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_conversations));

@override
String toString() {
  return 'ConversationsResponseDto(conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class _$ConversationsResponseDtoCopyWith<$Res> implements $ConversationsResponseDtoCopyWith<$Res> {
  factory _$ConversationsResponseDtoCopyWith(_ConversationsResponseDto value, $Res Function(_ConversationsResponseDto) _then) = __$ConversationsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ConversationsItemDto> conversations
});




}
/// @nodoc
class __$ConversationsResponseDtoCopyWithImpl<$Res>
    implements _$ConversationsResponseDtoCopyWith<$Res> {
  __$ConversationsResponseDtoCopyWithImpl(this._self, this._then);

  final _ConversationsResponseDto _self;
  final $Res Function(_ConversationsResponseDto) _then;

/// Create a copy of ConversationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversations = null,}) {
  return _then(_ConversationsResponseDto(
conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ConversationsItemDto>,
  ));
}


}


/// @nodoc
mixin _$ConversationsItemDto {

 String get id;@JsonKey(name: 'created_at') DateTime get createdAt; ConversationPartnerDto get partner;@JsonKey(name: 'last_message') MessageDto? get lastMessage;
/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsItemDtoCopyWith<ConversationsItemDto> get copyWith => _$ConversationsItemDtoCopyWithImpl<ConversationsItemDto>(this as ConversationsItemDto, _$identity);

  /// Serializes this ConversationsItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,partner,lastMessage);

@override
String toString() {
  return 'ConversationsItemDto(id: $id, createdAt: $createdAt, partner: $partner, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ConversationsItemDtoCopyWith<$Res>  {
  factory $ConversationsItemDtoCopyWith(ConversationsItemDto value, $Res Function(ConversationsItemDto) _then) = _$ConversationsItemDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'created_at') DateTime createdAt, ConversationPartnerDto partner,@JsonKey(name: 'last_message') MessageDto? lastMessage
});


$ConversationPartnerDtoCopyWith<$Res> get partner;$MessageDtoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ConversationsItemDtoCopyWithImpl<$Res>
    implements $ConversationsItemDtoCopyWith<$Res> {
  _$ConversationsItemDtoCopyWithImpl(this._self, this._then);

  final ConversationsItemDto _self;
  final $Res Function(ConversationsItemDto) _then;

/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? partner = null,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as ConversationPartnerDto,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as MessageDto?,
  ));
}
/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationPartnerDtoCopyWith<$Res> get partner {
  
  return $ConversationPartnerDtoCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageDtoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageDtoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConversationsItemDto].
extension ConversationsItemDtoPatterns on ConversationsItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationsItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationsItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationsItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ConversationsItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationsItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationsItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt,  ConversationPartnerDto partner, @JsonKey(name: 'last_message')  MessageDto? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationsItemDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.partner,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt,  ConversationPartnerDto partner, @JsonKey(name: 'last_message')  MessageDto? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ConversationsItemDto():
return $default(_that.id,_that.createdAt,_that.partner,_that.lastMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt,  ConversationPartnerDto partner, @JsonKey(name: 'last_message')  MessageDto? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConversationsItemDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.partner,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationsItemDto implements ConversationsItemDto {
  const _ConversationsItemDto({required this.id, @JsonKey(name: 'created_at') required this.createdAt, required this.partner, @JsonKey(name: 'last_message') this.lastMessage});
  factory _ConversationsItemDto.fromJson(Map<String, dynamic> json) => _$ConversationsItemDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  ConversationPartnerDto partner;
@override@JsonKey(name: 'last_message') final  MessageDto? lastMessage;

/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationsItemDtoCopyWith<_ConversationsItemDto> get copyWith => __$ConversationsItemDtoCopyWithImpl<_ConversationsItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationsItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationsItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,partner,lastMessage);

@override
String toString() {
  return 'ConversationsItemDto(id: $id, createdAt: $createdAt, partner: $partner, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ConversationsItemDtoCopyWith<$Res> implements $ConversationsItemDtoCopyWith<$Res> {
  factory _$ConversationsItemDtoCopyWith(_ConversationsItemDto value, $Res Function(_ConversationsItemDto) _then) = __$ConversationsItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'created_at') DateTime createdAt, ConversationPartnerDto partner,@JsonKey(name: 'last_message') MessageDto? lastMessage
});


@override $ConversationPartnerDtoCopyWith<$Res> get partner;@override $MessageDtoCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ConversationsItemDtoCopyWithImpl<$Res>
    implements _$ConversationsItemDtoCopyWith<$Res> {
  __$ConversationsItemDtoCopyWithImpl(this._self, this._then);

  final _ConversationsItemDto _self;
  final $Res Function(_ConversationsItemDto) _then;

/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? partner = null,Object? lastMessage = freezed,}) {
  return _then(_ConversationsItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,partner: null == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as ConversationPartnerDto,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as MessageDto?,
  ));
}

/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationPartnerDtoCopyWith<$Res> get partner {
  
  return $ConversationPartnerDtoCopyWith<$Res>(_self.partner, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of ConversationsItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageDtoCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageDtoCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

// dart format on
