// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_registration_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartRegistrationRequestDto {

 String get login; String get email; String get password;
/// Create a copy of StartRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartRegistrationRequestDtoCopyWith<StartRegistrationRequestDto> get copyWith => _$StartRegistrationRequestDtoCopyWithImpl<StartRegistrationRequestDto>(this as StartRegistrationRequestDto, _$identity);

  /// Serializes this StartRegistrationRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartRegistrationRequestDto&&(identical(other.login, login) || other.login == login)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,email,password);

@override
String toString() {
  return 'StartRegistrationRequestDto(login: $login, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $StartRegistrationRequestDtoCopyWith<$Res>  {
  factory $StartRegistrationRequestDtoCopyWith(StartRegistrationRequestDto value, $Res Function(StartRegistrationRequestDto) _then) = _$StartRegistrationRequestDtoCopyWithImpl;
@useResult
$Res call({
 String login, String email, String password
});




}
/// @nodoc
class _$StartRegistrationRequestDtoCopyWithImpl<$Res>
    implements $StartRegistrationRequestDtoCopyWith<$Res> {
  _$StartRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final StartRegistrationRequestDto _self;
  final $Res Function(StartRegistrationRequestDto) _then;

/// Create a copy of StartRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? login = null,Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StartRegistrationRequestDto].
extension StartRegistrationRequestDtoPatterns on StartRegistrationRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartRegistrationRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartRegistrationRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartRegistrationRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _StartRegistrationRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartRegistrationRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _StartRegistrationRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String login,  String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartRegistrationRequestDto() when $default != null:
return $default(_that.login,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String login,  String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _StartRegistrationRequestDto():
return $default(_that.login,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String login,  String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _StartRegistrationRequestDto() when $default != null:
return $default(_that.login,_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartRegistrationRequestDto implements StartRegistrationRequestDto {
  const _StartRegistrationRequestDto({required this.login, required this.email, required this.password});
  factory _StartRegistrationRequestDto.fromJson(Map<String, dynamic> json) => _$StartRegistrationRequestDtoFromJson(json);

@override final  String login;
@override final  String email;
@override final  String password;

/// Create a copy of StartRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartRegistrationRequestDtoCopyWith<_StartRegistrationRequestDto> get copyWith => __$StartRegistrationRequestDtoCopyWithImpl<_StartRegistrationRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartRegistrationRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartRegistrationRequestDto&&(identical(other.login, login) || other.login == login)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,email,password);

@override
String toString() {
  return 'StartRegistrationRequestDto(login: $login, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$StartRegistrationRequestDtoCopyWith<$Res> implements $StartRegistrationRequestDtoCopyWith<$Res> {
  factory _$StartRegistrationRequestDtoCopyWith(_StartRegistrationRequestDto value, $Res Function(_StartRegistrationRequestDto) _then) = __$StartRegistrationRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String login, String email, String password
});




}
/// @nodoc
class __$StartRegistrationRequestDtoCopyWithImpl<$Res>
    implements _$StartRegistrationRequestDtoCopyWith<$Res> {
  __$StartRegistrationRequestDtoCopyWithImpl(this._self, this._then);

  final _StartRegistrationRequestDto _self;
  final $Res Function(_StartRegistrationRequestDto) _then;

/// Create a copy of StartRegistrationRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? login = null,Object? email = null,Object? password = null,}) {
  return _then(_StartRegistrationRequestDto(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
