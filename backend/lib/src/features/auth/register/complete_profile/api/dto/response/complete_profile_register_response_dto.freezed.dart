// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_register_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompleteProfileRegisterResponseDto {

 String get id; String get email; String get username;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of CompleteProfileRegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteProfileRegisterResponseDtoCopyWith<CompleteProfileRegisterResponseDto> get copyWith => _$CompleteProfileRegisterResponseDtoCopyWithImpl<CompleteProfileRegisterResponseDto>(this as CompleteProfileRegisterResponseDto, _$identity);

  /// Serializes this CompleteProfileRegisterResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteProfileRegisterResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,displayName,createdAt);

@override
String toString() {
  return 'CompleteProfileRegisterResponseDto(id: $id, email: $email, username: $username, displayName: $displayName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CompleteProfileRegisterResponseDtoCopyWith<$Res>  {
  factory $CompleteProfileRegisterResponseDtoCopyWith(CompleteProfileRegisterResponseDto value, $Res Function(CompleteProfileRegisterResponseDto) _then) = _$CompleteProfileRegisterResponseDtoCopyWithImpl;
@useResult
$Res call({
 String id, String email, String username,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$CompleteProfileRegisterResponseDtoCopyWithImpl<$Res>
    implements $CompleteProfileRegisterResponseDtoCopyWith<$Res> {
  _$CompleteProfileRegisterResponseDtoCopyWithImpl(this._self, this._then);

  final CompleteProfileRegisterResponseDto _self;
  final $Res Function(CompleteProfileRegisterResponseDto) _then;

/// Create a copy of CompleteProfileRegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? username = null,Object? displayName = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CompleteProfileRegisterResponseDto].
extension CompleteProfileRegisterResponseDtoPatterns on CompleteProfileRegisterResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteProfileRegisterResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteProfileRegisterResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteProfileRegisterResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String username, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto() when $default != null:
return $default(_that.id,_that.email,_that.username,_that.displayName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String username, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto():
return $default(_that.id,_that.email,_that.username,_that.displayName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String username, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CompleteProfileRegisterResponseDto() when $default != null:
return $default(_that.id,_that.email,_that.username,_that.displayName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompleteProfileRegisterResponseDto implements CompleteProfileRegisterResponseDto {
  const _CompleteProfileRegisterResponseDto({required this.id, required this.email, required this.username, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'created_at') required this.createdAt});
  factory _CompleteProfileRegisterResponseDto.fromJson(Map<String, dynamic> json) => _$CompleteProfileRegisterResponseDtoFromJson(json);

@override final  String id;
@override final  String email;
@override final  String username;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of CompleteProfileRegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteProfileRegisterResponseDtoCopyWith<_CompleteProfileRegisterResponseDto> get copyWith => __$CompleteProfileRegisterResponseDtoCopyWithImpl<_CompleteProfileRegisterResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteProfileRegisterResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteProfileRegisterResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,displayName,createdAt);

@override
String toString() {
  return 'CompleteProfileRegisterResponseDto(id: $id, email: $email, username: $username, displayName: $displayName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CompleteProfileRegisterResponseDtoCopyWith<$Res> implements $CompleteProfileRegisterResponseDtoCopyWith<$Res> {
  factory _$CompleteProfileRegisterResponseDtoCopyWith(_CompleteProfileRegisterResponseDto value, $Res Function(_CompleteProfileRegisterResponseDto) _then) = __$CompleteProfileRegisterResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String username,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$CompleteProfileRegisterResponseDtoCopyWithImpl<$Res>
    implements _$CompleteProfileRegisterResponseDtoCopyWith<$Res> {
  __$CompleteProfileRegisterResponseDtoCopyWithImpl(this._self, this._then);

  final _CompleteProfileRegisterResponseDto _self;
  final $Res Function(_CompleteProfileRegisterResponseDto) _then;

/// Create a copy of CompleteProfileRegisterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? username = null,Object? displayName = null,Object? createdAt = null,}) {
  return _then(_CompleteProfileRegisterResponseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
