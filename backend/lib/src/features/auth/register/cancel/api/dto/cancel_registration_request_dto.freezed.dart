// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancel_registration_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CancelRegistrationRequestDto {

@JsonKey(name: 'registration_id') String get registrationId;
/// Create a copy of CancelRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelRegistrationRequestDtoCopyWith<CancelRegistrationRequestDto> get copyWith => _$CancelRegistrationRequestDtoCopyWithImpl<CancelRegistrationRequestDto>(this as CancelRegistrationRequestDto, _$identity);

  /// Serializes this CancelRegistrationRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelRegistrationRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId);

@override
String toString() {
  return 'CancelRegistrationRequestDto(registrationId: $registrationId)';
}


}

/// @nodoc
abstract mixin class $CancelRegistrationRequestDtoCopyWith<$Res>  {
  factory $CancelRegistrationRequestDtoCopyWith(CancelRegistrationRequestDto value, $Res Function(CancelRegistrationRequestDto) _then) = _$CancelRegistrationRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId
});




}
/// @nodoc
class _$CancelRegistrationRequestDtoCopyWithImpl<$Res>
    implements $CancelRegistrationRequestDtoCopyWith<$Res> {
  _$CancelRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final CancelRegistrationRequestDto _self;
  final $Res Function(CancelRegistrationRequestDto) _then;

/// Create a copy of CancelRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CancelRegistrationRequestDto].
extension CancelRegistrationRequestDtoPatterns on CancelRegistrationRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CancelRegistrationRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CancelRegistrationRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CancelRegistrationRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CancelRegistrationRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CancelRegistrationRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CancelRegistrationRequestDto() when $default != null:
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
case _CancelRegistrationRequestDto() when $default != null:
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
case _CancelRegistrationRequestDto():
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
case _CancelRegistrationRequestDto() when $default != null:
return $default(_that.registrationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CancelRegistrationRequestDto implements CancelRegistrationRequestDto {
  const _CancelRegistrationRequestDto({@JsonKey(name: 'registration_id') required this.registrationId});
  factory _CancelRegistrationRequestDto.fromJson(Map<String, dynamic> json) => _$CancelRegistrationRequestDtoFromJson(json);

@override@JsonKey(name: 'registration_id') final  String registrationId;

/// Create a copy of CancelRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelRegistrationRequestDtoCopyWith<_CancelRegistrationRequestDto> get copyWith => __$CancelRegistrationRequestDtoCopyWithImpl<_CancelRegistrationRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CancelRegistrationRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelRegistrationRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId);

@override
String toString() {
  return 'CancelRegistrationRequestDto(registrationId: $registrationId)';
}


}

/// @nodoc
abstract mixin class _$CancelRegistrationRequestDtoCopyWith<$Res> implements $CancelRegistrationRequestDtoCopyWith<$Res> {
  factory _$CancelRegistrationRequestDtoCopyWith(_CancelRegistrationRequestDto value, $Res Function(_CancelRegistrationRequestDto) _then) = __$CancelRegistrationRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId
});




}
/// @nodoc
class __$CancelRegistrationRequestDtoCopyWithImpl<$Res>
    implements _$CancelRegistrationRequestDtoCopyWith<$Res> {
  __$CancelRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final _CancelRegistrationRequestDto _self;
  final $Res Function(_CancelRegistrationRequestDto) _then;

/// Create a copy of CancelRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,}) {
  return _then(_CancelRegistrationRequestDto(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
