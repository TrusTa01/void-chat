// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompleteProfileRequestDto {

@JsonKey(name: 'registration_id') String get registrationId; String get username;@JsonKey(name: 'display_name') String get displayName;
/// Create a copy of CompleteProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteProfileRequestDtoCopyWith<CompleteProfileRequestDto> get copyWith => _$CompleteProfileRequestDtoCopyWithImpl<CompleteProfileRequestDto>(this as CompleteProfileRequestDto, _$identity);

  /// Serializes this CompleteProfileRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,username,displayName);

@override
String toString() {
  return 'CompleteProfileRequestDto(registrationId: $registrationId, username: $username, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $CompleteProfileRequestDtoCopyWith<$Res>  {
  factory $CompleteProfileRequestDtoCopyWith(CompleteProfileRequestDto value, $Res Function(CompleteProfileRequestDto) _then) = _$CompleteProfileRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String username,@JsonKey(name: 'display_name') String displayName
});




}
/// @nodoc
class _$CompleteProfileRequestDtoCopyWithImpl<$Res>
    implements $CompleteProfileRequestDtoCopyWith<$Res> {
  _$CompleteProfileRequestDtoCopyWithImpl(this._self, this._then);

  final CompleteProfileRequestDto _self;
  final $Res Function(CompleteProfileRequestDto) _then;

/// Create a copy of CompleteProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,Object? username = null,Object? displayName = null,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompleteProfileRequestDto].
extension CompleteProfileRequestDtoPatterns on CompleteProfileRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteProfileRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteProfileRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteProfileRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteProfileRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId,  String username, @JsonKey(name: 'display_name')  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteProfileRequestDto() when $default != null:
return $default(_that.registrationId,_that.username,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId,  String username, @JsonKey(name: 'display_name')  String displayName)  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileRequestDto():
return $default(_that.registrationId,_that.username,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'registration_id')  String registrationId,  String username, @JsonKey(name: 'display_name')  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileRequestDto() when $default != null:
return $default(_that.registrationId,_that.username,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompleteProfileRequestDto implements CompleteProfileRequestDto {
  const _CompleteProfileRequestDto({@JsonKey(name: 'registration_id') required this.registrationId, required this.username, @JsonKey(name: 'display_name') required this.displayName});
  factory _CompleteProfileRequestDto.fromJson(Map<String, dynamic> json) => _$CompleteProfileRequestDtoFromJson(json);

@override@JsonKey(name: 'registration_id') final  String registrationId;
@override final  String username;
@override@JsonKey(name: 'display_name') final  String displayName;

/// Create a copy of CompleteProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteProfileRequestDtoCopyWith<_CompleteProfileRequestDto> get copyWith => __$CompleteProfileRequestDtoCopyWithImpl<_CompleteProfileRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteProfileRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteProfileRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,username,displayName);

@override
String toString() {
  return 'CompleteProfileRequestDto(registrationId: $registrationId, username: $username, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$CompleteProfileRequestDtoCopyWith<$Res> implements $CompleteProfileRequestDtoCopyWith<$Res> {
  factory _$CompleteProfileRequestDtoCopyWith(_CompleteProfileRequestDto value, $Res Function(_CompleteProfileRequestDto) _then) = __$CompleteProfileRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String username,@JsonKey(name: 'display_name') String displayName
});




}
/// @nodoc
class __$CompleteProfileRequestDtoCopyWithImpl<$Res>
    implements _$CompleteProfileRequestDtoCopyWith<$Res> {
  __$CompleteProfileRequestDtoCopyWithImpl(this._self, this._then);

  final _CompleteProfileRequestDto _self;
  final $Res Function(_CompleteProfileRequestDto) _then;

/// Create a copy of CompleteProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,Object? username = null,Object? displayName = null,}) {
  return _then(_CompleteProfileRequestDto(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
