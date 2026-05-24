import 'dart:convert';

import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

T parseBody<T>(String body, T Function(Map<String, dynamic>) fromJson) {
  final dynamic decoded;
  try {
    decoded = jsonDecode(body);
  } on FormatException {
    throw const ValidationException('INVALID_JSON', 'Invalid JSON format');
  }

  if (decoded is! Map<String, dynamic>) {
    throw const ValidationException('INVALID_BODY', 'JSON object expected');
  }

  try {
    return fromJson(decoded);
  } on TypeError catch (e) {
    throw ValidationException(
      AuthErrorCodes.invalidRequestFields,
      'Invalid field type: ${e.toString()}',
    );
  } on CheckedFromJsonException catch (e) {
    throw ValidationException(
      AuthErrorCodes.invalidRequestFields,
      e.message ?? 'Missing or invalid fields',
    );
  } catch (e) {
    rethrow;
  }
}
