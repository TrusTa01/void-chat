// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_registration_email_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyRegistrationEmailResponseDto {

 bool get verified;
/// Create a copy of VerifyRegistrationEmailResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyRegistrationEmailResponseDtoCopyWith<VerifyRegistrationEmailResponseDto> get copyWith => _$VerifyRegistrationEmailResponseDtoCopyWithImpl<VerifyRegistrationEmailResponseDto>(this as VerifyRegistrationEmailResponseDto, _$identity);

  /// Serializes this VerifyRegistrationEmailResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyRegistrationEmailResponseDto&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verified);

@override
String toString() {
  return 'VerifyRegistrationEmailResponseDto(verified: $verified)';
}


}

/// @nodoc
abstract mixin class $VerifyRegistrationEmailResponseDtoCopyWith<$Res>  {
  factory $VerifyRegistrationEmailResponseDtoCopyWith(VerifyRegistrationEmailResponseDto value, $Res Function(VerifyRegistrationEmailResponseDto) _then) = _$VerifyRegistrationEmailResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool verified
});




}
/// @nodoc
class _$VerifyRegistrationEmailResponseDtoCopyWithImpl<$Res>
    implements $VerifyRegistrationEmailResponseDtoCopyWith<$Res> {
  _$VerifyRegistrationEmailResponseDtoCopyWithImpl(this._self, this._then);

  final VerifyRegistrationEmailResponseDto _self;
  final $Res Function(VerifyRegistrationEmailResponseDto) _then;

/// Create a copy of VerifyRegistrationEmailResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verified = null,}) {
  return _then(_self.copyWith(
verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyRegistrationEmailResponseDto].
extension VerifyRegistrationEmailResponseDtoPatterns on VerifyRegistrationEmailResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyRegistrationEmailResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyRegistrationEmailResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyRegistrationEmailResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto() when $default != null:
return $default(_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool verified)  $default,) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto():
return $default(_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool verified)?  $default,) {final _that = this;
switch (_that) {
case _VerifyRegistrationEmailResponseDto() when $default != null:
return $default(_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyRegistrationEmailResponseDto implements VerifyRegistrationEmailResponseDto {
  const _VerifyRegistrationEmailResponseDto({required this.verified});
  factory _VerifyRegistrationEmailResponseDto.fromJson(Map<String, dynamic> json) => _$VerifyRegistrationEmailResponseDtoFromJson(json);

@override final  bool verified;

/// Create a copy of VerifyRegistrationEmailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyRegistrationEmailResponseDtoCopyWith<_VerifyRegistrationEmailResponseDto> get copyWith => __$VerifyRegistrationEmailResponseDtoCopyWithImpl<_VerifyRegistrationEmailResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyRegistrationEmailResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyRegistrationEmailResponseDto&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verified);

@override
String toString() {
  return 'VerifyRegistrationEmailResponseDto(verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$VerifyRegistrationEmailResponseDtoCopyWith<$Res> implements $VerifyRegistrationEmailResponseDtoCopyWith<$Res> {
  factory _$VerifyRegistrationEmailResponseDtoCopyWith(_VerifyRegistrationEmailResponseDto value, $Res Function(_VerifyRegistrationEmailResponseDto) _then) = __$VerifyRegistrationEmailResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool verified
});




}
/// @nodoc
class __$VerifyRegistrationEmailResponseDtoCopyWithImpl<$Res>
    implements _$VerifyRegistrationEmailResponseDtoCopyWith<$Res> {
  __$VerifyRegistrationEmailResponseDtoCopyWithImpl(this._self, this._then);

  final _VerifyRegistrationEmailResponseDto _self;
  final $Res Function(_VerifyRegistrationEmailResponseDto) _then;

/// Create a copy of VerifyRegistrationEmailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verified = null,}) {
  return _then(_VerifyRegistrationEmailResponseDto(
verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
