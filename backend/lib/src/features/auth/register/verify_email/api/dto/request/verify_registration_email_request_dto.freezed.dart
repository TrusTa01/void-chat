// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_registration_email_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyRegistrationEmailRequestDto {

@JsonKey(name: 'registration_id') String get registrationId; String get code;
/// Create a copy of VerifyRegistrationEmailRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyRegistrationEmailRequestDtoCopyWith<VerifyRegistrationEmailRequestDto> get copyWith => _$VerifyRegistrationEmailRequestDtoCopyWithImpl<VerifyRegistrationEmailRequestDto>(this as VerifyRegistrationEmailRequestDto, _$identity);

  /// Serializes this VerifyRegistrationEmailRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyRegistrationEmailRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,code);

@override
String toString() {
  return 'VerifyRegistrationEmailRequestDto(registrationId: $registrationId, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyRegistrationEmailRequestDtoCopyWith<$Res>  {
  factory $VerifyRegistrationEmailRequestDtoCopyWith(VerifyRegistrationEmailRequestDto value, $Res Function(VerifyRegistrationEmailRequestDto) _then) = _$VerifyRegistrationEmailRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String code
});




}
/// @nodoc
class _$VerifyRegistrationEmailRequestDtoCopyWithImpl<$Res>
    implements $VerifyRegistrationEmailRequestDtoCopyWith<$Res> {
  _$VerifyRegistrationEmailRequestDtoCopyWithImpl(this._self, this._then);

  final VerifyRegistrationEmailRequestDto _self;
  final $Res Function(VerifyRegistrationEmailRequestDto) _then;

/// Create a copy of VerifyRegistrationEmailRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,Object? code = null,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyRegistrationEmailRequestDto].
extension VerifyRegistrationEmailRequestDtoPatterns on VerifyRegistrationEmailRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyRegistrationEmailRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyRegistrationEmailRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyRegistrationEmailRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto() when $default != null:
return $default(_that.registrationId,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'registration_id')  String registrationId,  String code)  $default,) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto():
return $default(_that.registrationId,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'registration_id')  String registrationId,  String code)?  $default,) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailRequestDto() when $default != null:
return $default(_that.registrationId,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyRegistrationEmailRequestDto implements VerifyRegistrationEmailRequestDto {
  const _VerifyRegistrationEmailRequestDto({@JsonKey(name: 'registration_id') required this.registrationId, required this.code});
  factory _VerifyRegistrationEmailRequestDto.fromJson(Map<String, dynamic> json) => _$VerifyRegistrationEmailRequestDtoFromJson(json);

@override@JsonKey(name: 'registration_id') final  String registrationId;
@override final  String code;

/// Create a copy of VerifyRegistrationEmailRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyRegistrationEmailRequestDtoCopyWith<_VerifyRegistrationEmailRequestDto> get copyWith => __$VerifyRegistrationEmailRequestDtoCopyWithImpl<_VerifyRegistrationEmailRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyRegistrationEmailRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyRegistrationEmailRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,code);

@override
String toString() {
  return 'VerifyRegistrationEmailRequestDto(registrationId: $registrationId, code: $code)';
}


}

/// @nodoc
abstract mixin class _$VerifyRegistrationEmailRequestDtoCopyWith<$Res> implements $VerifyRegistrationEmailRequestDtoCopyWith<$Res> {
  factory _$VerifyRegistrationEmailRequestDtoCopyWith(_VerifyRegistrationEmailRequestDto value, $Res Function(_VerifyRegistrationEmailRequestDto) _then) = __$VerifyRegistrationEmailRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String code
});




}
/// @nodoc
class __$VerifyRegistrationEmailRequestDtoCopyWithImpl<$Res>
    implements _$VerifyRegistrationEmailRequestDtoCopyWith<$Res> {
  __$VerifyRegistrationEmailRequestDtoCopyWithImpl(this._self, this._then);

  final _VerifyRegistrationEmailRequestDto _self;
  final $Res Function(_VerifyRegistrationEmailRequestDto) _then;

/// Create a copy of VerifyRegistrationEmailRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,Object? code = null,}) {
  return _then(_VerifyRegistrationEmailRequestDto(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
