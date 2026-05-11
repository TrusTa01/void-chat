import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';
import 'package:backend/src/features/auth/register/api/dto/request/register_request_dto.dart';
import 'package:backend/src/features/auth/register/api/mappers/register_request_mapper.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

NewUser parseRegisterBody(Map<String, dynamic> decoded) {
  try {
    final dto = RegisterRequestDto.fromJson(decoded);
    return dto.toNewUser();
  } on TypeError catch (_) {
    throw const ValidationException(
      AuthErrorCodes.invalidRequestFields,
      'Registration fields must be strings: login, password, email, '
      'username, display_name',
    );
  } on CheckedFromJsonException catch (e) {
    throw ValidationException(
      AuthErrorCodes.invalidRequestFields,
      e.message ?? 'Missing or invalid registration fields',
    );
  }
}
