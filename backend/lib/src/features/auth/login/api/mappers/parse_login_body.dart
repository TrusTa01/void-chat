import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/api/dto/request/login_request_dto.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

LoginRequestDto parseLoginBody(Map<String, dynamic> decoded) {
  try {
    return LoginRequestDto.fromJson(decoded);
  } on TypeError catch (_) {
    throw const ValidationException(
      AuthErrorCodes.invalidRequestFields,
      'Login fields must be strings: identifier, password',
    );
  } on CheckedFromJsonException catch (e) {
    throw ValidationException(
      AuthErrorCodes.invalidRequestFields,
      e.message ?? 'Missing or invalid fields',
    );
  }
}
