// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_registration_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartRegistrationResponseDto {

@JsonKey(name: 'registration_id') String get registrationId;
/// Create a copy of StartRegistrationResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartRegistrationResponseDtoCopyWith<StartRegistrationResponseDto> get copyWith => _$StartRegistrationResponseDtoCopyWithImpl<StartRegistrationResponseDto>(this as StartRegistrationResponseDto, _$identity);

  /// Serializes this StartRegistrationResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartRegistrationResponseDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId);

@override
String toString() {
  return 'StartRegistrationResponseDto(registrationId: $registrationId)';
}


}

/// @nodoc
abstract mixin class $StartRegistrationResponseDtoCopyWith<$Res>  {
  factory $StartRegistrationResponseDtoCopyWith(StartRegistrationResponseDto value, $Res Function(StartRegistrationResponseDto) _then) = _$StartRegistrationResponseDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId
});




}
/// @nodoc
class _$StartRegistrationResponseDtoCopyWithImpl<$Res>
    implements $StartRegistrationResponseDtoCopyWith<$Res> {
  _$StartRegistrationResponseDtoCopyWithImpl(this._self, this._then);

  final StartRegistrationResponseDto _self;
  final $Res Function(StartRegistrationResponseDto) _then;

/// Create a copy of StartRegistrationResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StartRegistrationResponseDto].
extension StartRegistrationResponseDtoPatterns on StartRegistrationResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartRegistrationResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartRegistrationResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartRegistrationResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _StartRegistrationResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartRegistrationResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _StartRegistrationResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartRegistrationResponseDto() when $default != null:
return $default(_that.registrationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId)  $default,) {final _that = this;
switch (_that) {
case _StartRegistrationResponseDto():
return $default(_that.registrationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'registration_id')  String registrationId)?  $default,) {final _that = this;
switch (_that) {
case _StartRegistrationResponseDto() when $default != null:
return $default(_that.registrationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartRegistrationResponseDto implements StartRegistrationResponseDto {
  const _StartRegistrationResponseDto({@JsonKey(name: 'registration_id') required this.registrationId});
  factory _StartRegistrationResponseDto.fromJson(Map<String, dynamic> json) => _$StartRegistrationResponseDtoFromJson(json);

@override@JsonKey(name: 'registration_id') final  String registrationId;

/// Create a copy of StartRegistrationResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartRegistrationResponseDtoCopyWith<_StartRegistrationResponseDto> get copyWith => __$StartRegistrationResponseDtoCopyWithImpl<_StartRegistrationResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartRegistrationResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartRegistrationResponseDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId);

@override
String toString() {
  return 'StartRegistrationResponseDto(registrationId: $registrationId)';
}


}

/// @nodoc
abstract mixin class _$StartRegistrationResponseDtoCopyWith<$Res> implements $StartRegistrationResponseDtoCopyWith<$Res> {
  factory _$StartRegistrationResponseDtoCopyWith(_StartRegistrationResponseDto value, $Res Function(_StartRegistrationResponseDto) _then) = __$StartRegistrationResponseDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId
});




}
/// @nodoc
class __$StartRegistrationResponseDtoCopyWithImpl<$Res>
    implements _$StartRegistrationResponseDtoCopyWith<$Res> {
  __$StartRegistrationResponseDtoCopyWithImpl(this._self, this._then);

  final _StartRegistrationResponseDto _self;
  final $Res Function(_StartRegistrationResponseDto) _then;

/// Create a copy of StartRegistrationResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,}) {
  return _then(_StartRegistrationResponseDto(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
