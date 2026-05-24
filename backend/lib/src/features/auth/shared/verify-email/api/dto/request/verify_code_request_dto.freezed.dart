// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_code_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CodeVerifyRequestDto {

@JsonKey(name: 'registration_id') String get registrationId; String get code;
/// Create a copy of CodeVerifyRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeVerifyRequestDtoCopyWith<CodeVerifyRequestDto> get copyWith => _$CodeVerifyRequestDtoCopyWithImpl<CodeVerifyRequestDto>(this as CodeVerifyRequestDto, _$identity);

  /// Serializes this CodeVerifyRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeVerifyRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,code);

@override
String toString() {
  return 'CodeVerifyRequestDto(registrationId: $registrationId, code: $code)';
}


}

/// @nodoc
abstract mixin class $CodeVerifyRequestDtoCopyWith<$Res>  {
  factory $CodeVerifyRequestDtoCopyWith(CodeVerifyRequestDto value, $Res Function(CodeVerifyRequestDto) _then) = _$CodeVerifyRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String code
});




}
/// @nodoc
class _$CodeVerifyRequestDtoCopyWithImpl<$Res>
    implements $CodeVerifyRequestDtoCopyWith<$Res> {
  _$CodeVerifyRequestDtoCopyWithImpl(this._self, this._then);

  final CodeVerifyRequestDto _self;
  final $Res Function(CodeVerifyRequestDto) _then;

/// Create a copy of CodeVerifyRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registrationId = null,Object? code = null,}) {
  return _then(_self.copyWith(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeVerifyRequestDto].
extension CodeVerifyRequestDtoPatterns on CodeVerifyRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeVerifyRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeVerifyRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeVerifyRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CodeVerifyRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeVerifyRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CodeVerifyRequestDto() when $default != null:
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
case _CodeVerifyRequestDto() when $default != null:
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
case _CodeVerifyRequestDto():
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
case _CodeVerifyRequestDto() when $default != null:
return $default(_that.registrationId,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CodeVerifyRequestDto implements CodeVerifyRequestDto {
  const _CodeVerifyRequestDto({@JsonKey(name: 'registration_id') required this.registrationId, required this.code});
  factory _CodeVerifyRequestDto.fromJson(Map<String, dynamic> json) => _$CodeVerifyRequestDtoFromJson(json);

@override@JsonKey(name: 'registration_id') final  String registrationId;
@override final  String code;

/// Create a copy of CodeVerifyRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeVerifyRequestDtoCopyWith<_CodeVerifyRequestDto> get copyWith => __$CodeVerifyRequestDtoCopyWithImpl<_CodeVerifyRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeVerifyRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeVerifyRequestDto&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registrationId,code);

@override
String toString() {
  return 'CodeVerifyRequestDto(registrationId: $registrationId, code: $code)';
}


}

/// @nodoc
abstract mixin class _$CodeVerifyRequestDtoCopyWith<$Res> implements $CodeVerifyRequestDtoCopyWith<$Res> {
  factory _$CodeVerifyRequestDtoCopyWith(_CodeVerifyRequestDto value, $Res Function(_CodeVerifyRequestDto) _then) = __$CodeVerifyRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'registration_id') String registrationId, String code
});




}
/// @nodoc
class __$CodeVerifyRequestDtoCopyWithImpl<$Res>
    implements _$CodeVerifyRequestDtoCopyWith<$Res> {
  __$CodeVerifyRequestDtoCopyWithImpl(this._self, this._then);

  final _CodeVerifyRequestDto _self;
  final $Res Function(_CodeVerifyRequestDto) _then;

/// Create a copy of CodeVerifyRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? registrationId = null,Object? code = null,}) {
  return _then(_CodeVerifyRequestDto(
registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
