// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_code_verify_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginCodeVerifyDto {

 String get identifier; String get code;
/// Create a copy of LoginCodeVerifyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginCodeVerifyDtoCopyWith<LoginCodeVerifyDto> get copyWith => _$LoginCodeVerifyDtoCopyWithImpl<LoginCodeVerifyDto>(this as LoginCodeVerifyDto, _$identity);

  /// Serializes this LoginCodeVerifyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginCodeVerifyDto&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,code);

@override
String toString() {
  return 'LoginCodeVerifyDto(identifier: $identifier, code: $code)';
}


}

/// @nodoc
abstract mixin class $LoginCodeVerifyDtoCopyWith<$Res>  {
  factory $LoginCodeVerifyDtoCopyWith(LoginCodeVerifyDto value, $Res Function(LoginCodeVerifyDto) _then) = _$LoginCodeVerifyDtoCopyWithImpl;
@useResult
$Res call({
 String identifier, String code
});




}
/// @nodoc
class _$LoginCodeVerifyDtoCopyWithImpl<$Res>
    implements $LoginCodeVerifyDtoCopyWith<$Res> {
  _$LoginCodeVerifyDtoCopyWithImpl(this._self, this._then);

  final LoginCodeVerifyDto _self;
  final $Res Function(LoginCodeVerifyDto) _then;

/// Create a copy of LoginCodeVerifyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? code = null,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginCodeVerifyDto].
extension LoginCodeVerifyDtoPatterns on LoginCodeVerifyDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginCodeVerifyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginCodeVerifyDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginCodeVerifyDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginCodeVerifyDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginCodeVerifyDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginCodeVerifyDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginCodeVerifyDto() when $default != null:
return $default(_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String code)  $default,) {final _that = this;
switch (_that) {
case _LoginCodeVerifyDto():
return $default(_that.identifier,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String code)?  $default,) {final _that = this;
switch (_that) {
case _LoginCodeVerifyDto() when $default != null:
return $default(_that.identifier,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginCodeVerifyDto implements LoginCodeVerifyDto {
  const _LoginCodeVerifyDto({required this.identifier, required this.code});
  factory _LoginCodeVerifyDto.fromJson(Map<String, dynamic> json) => _$LoginCodeVerifyDtoFromJson(json);

@override final  String identifier;
@override final  String code;

/// Create a copy of LoginCodeVerifyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginCodeVerifyDtoCopyWith<_LoginCodeVerifyDto> get copyWith => __$LoginCodeVerifyDtoCopyWithImpl<_LoginCodeVerifyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginCodeVerifyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginCodeVerifyDto&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,code);

@override
String toString() {
  return 'LoginCodeVerifyDto(identifier: $identifier, code: $code)';
}


}

/// @nodoc
abstract mixin class _$LoginCodeVerifyDtoCopyWith<$Res> implements $LoginCodeVerifyDtoCopyWith<$Res> {
  factory _$LoginCodeVerifyDtoCopyWith(_LoginCodeVerifyDto value, $Res Function(_LoginCodeVerifyDto) _then) = __$LoginCodeVerifyDtoCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String code
});




}
/// @nodoc
class __$LoginCodeVerifyDtoCopyWithImpl<$Res>
    implements _$LoginCodeVerifyDtoCopyWith<$Res> {
  __$LoginCodeVerifyDtoCopyWithImpl(this._self, this._then);

  final _LoginCodeVerifyDto _self;
  final $Res Function(_LoginCodeVerifyDto) _then;

/// Create a copy of LoginCodeVerifyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? code = null,}) {
  return _then(_LoginCodeVerifyDto(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
