// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_conversation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateConversationRequestDto {

 List<String> get participantIds;
/// Create a copy of CreateConversationRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateConversationRequestDtoCopyWith<CreateConversationRequestDto> get copyWith => _$CreateConversationRequestDtoCopyWithImpl<CreateConversationRequestDto>(this as CreateConversationRequestDto, _$identity);

  /// Serializes this CreateConversationRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateConversationRequestDto&&const DeepCollectionEquality().equals(other.participantIds, participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(participantIds));

@override
String toString() {
  return 'CreateConversationRequestDto(participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class $CreateConversationRequestDtoCopyWith<$Res>  {
  factory $CreateConversationRequestDtoCopyWith(CreateConversationRequestDto value, $Res Function(CreateConversationRequestDto) _then) = _$CreateConversationRequestDtoCopyWithImpl;
@useResult
$Res call({
 List<String> participantIds
});




}
/// @nodoc
class _$CreateConversationRequestDtoCopyWithImpl<$Res>
    implements $CreateConversationRequestDtoCopyWith<$Res> {
  _$CreateConversationRequestDtoCopyWithImpl(this._self, this._then);

  final CreateConversationRequestDto _self;
  final $Res Function(CreateConversationRequestDto) _then;

/// Create a copy of CreateConversationRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participantIds = null,}) {
  return _then(_self.copyWith(
participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateConversationRequestDto].
extension CreateConversationRequestDtoPatterns on CreateConversationRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateConversationRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateConversationRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateConversationRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateConversationRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateConversationRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateConversationRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> participantIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateConversationRequestDto() when $default != null:
return $default(_that.participantIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> participantIds)  $default,) {final _that = this;
switch (_that) {
case _CreateConversationRequestDto():
return $default(_that.participantIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> participantIds)?  $default,) {final _that = this;
switch (_that) {
case _CreateConversationRequestDto() when $default != null:
return $default(_that.participantIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateConversationRequestDto implements CreateConversationRequestDto {
  const _CreateConversationRequestDto({required final  List<String> participantIds}): _participantIds = participantIds;
  factory _CreateConversationRequestDto.fromJson(Map<String, dynamic> json) => _$CreateConversationRequestDtoFromJson(json);

 final  List<String> _participantIds;
@override List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}


/// Create a copy of CreateConversationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateConversationRequestDtoCopyWith<_CreateConversationRequestDto> get copyWith => __$CreateConversationRequestDtoCopyWithImpl<_CreateConversationRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateConversationRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateConversationRequestDto&&const DeepCollectionEquality().equals(other._participantIds, _participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_participantIds));

@override
String toString() {
  return 'CreateConversationRequestDto(participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class _$CreateConversationRequestDtoCopyWith<$Res> implements $CreateConversationRequestDtoCopyWith<$Res> {
  factory _$CreateConversationRequestDtoCopyWith(_CreateConversationRequestDto value, $Res Function(_CreateConversationRequestDto) _then) = __$CreateConversationRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 List<String> participantIds
});




}
/// @nodoc
class __$CreateConversationRequestDtoCopyWithImpl<$Res>
    implements _$CreateConversationRequestDtoCopyWith<$Res> {
  __$CreateConversationRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateConversationRequestDto _self;
  final $Res Function(_CreateConversationRequestDto) _then;

/// Create a copy of CreateConversationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participantIds = null,}) {
  return _then(_CreateConversationRequestDto(
participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
