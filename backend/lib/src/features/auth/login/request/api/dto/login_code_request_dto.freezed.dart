// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_code_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginCodeRequestDto {

 String get identifier;
/// Create a copy of LoginCodeRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginCodeRequestDtoCopyWith<LoginCodeRequestDto> get copyWith => _$LoginCodeRequestDtoCopyWithImpl<LoginCodeRequestDto>(this as LoginCodeRequestDto, _$identity);

  /// Serializes this LoginCodeRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginCodeRequestDto&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier);

@override
String toString() {
  return 'LoginCodeRequestDto(identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class $LoginCodeRequestDtoCopyWith<$Res>  {
  factory $LoginCodeRequestDtoCopyWith(LoginCodeRequestDto value, $Res Function(LoginCodeRequestDto) _then) = _$LoginCodeRequestDtoCopyWithImpl;
@useResult
$Res call({
 String identifier
});




}
/// @nodoc
class _$LoginCodeRequestDtoCopyWithImpl<$Res>
    implements $LoginCodeRequestDtoCopyWith<$Res> {
  _$LoginCodeRequestDtoCopyWithImpl(this._self, this._then);

  final LoginCodeRequestDto _self;
  final $Res Function(LoginCodeRequestDto) _then;

/// Create a copy of LoginCodeRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginCodeRequestDto].
extension LoginCodeRequestDtoPatterns on LoginCodeRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginCodeRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginCodeRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginCodeRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginCodeRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginCodeRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginCodeRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginCodeRequestDto() when $default != null:
return $default(_that.identifier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier)  $default,) {final _that = this;
switch (_that) {
case _LoginCodeRequestDto():
return $default(_that.identifier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier)?  $default,) {final _that = this;
switch (_that) {
case _LoginCodeRequestDto() when $default != null:
return $default(_that.identifier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginCodeRequestDto implements LoginCodeRequestDto {
  const _LoginCodeRequestDto({required this.identifier});
  factory _LoginCodeRequestDto.fromJson(Map<String, dynamic> json) => _$LoginCodeRequestDtoFromJson(json);

@override final  String identifier;

/// Create a copy of LoginCodeRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginCodeRequestDtoCopyWith<_LoginCodeRequestDto> get copyWith => __$LoginCodeRequestDtoCopyWithImpl<_LoginCodeRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginCodeRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginCodeRequestDto&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier);

@override
String toString() {
  return 'LoginCodeRequestDto(identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class _$LoginCodeRequestDtoCopyWith<$Res> implements $LoginCodeRequestDtoCopyWith<$Res> {
  factory _$LoginCodeRequestDtoCopyWith(_LoginCodeRequestDto value, $Res Function(_LoginCodeRequestDto) _then) = __$LoginCodeRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String identifier
});




}
/// @nodoc
class __$LoginCodeRequestDtoCopyWithImpl<$Res>
    implements _$LoginCodeRequestDtoCopyWith<$Res> {
  __$LoginCodeRequestDtoCopyWithImpl(this._self, this._then);

  final _LoginCodeRequestDto _self;
  final $Res Function(_LoginCodeRequestDto) _then;

/// Create a copy of LoginCodeRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,}) {
  return _then(_LoginCodeRequestDto(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
