import 'dart:convert';

import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/features/auth/api/dto/request/register_request_dto.dart';
import 'package:backend/features/auth/auth_error_codes.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

extension RegisterRequestMapper on RegisterRequestDto {
  NewUser toNewUser() {
    return NewUser.validate(
      login: login,
      password: password,
      email: email,
      username: username,
      displayName: displayName,
    );
  }
}

NewUser parseRegisterBody(String body) {
  final dynamic decoded;

  try {
    decoded = jsonDecode(body);
  } on FormatException {
    rethrow;
  }

  if (decoded is! Map<String, dynamic>) {
    throw const ValidationException(
      'INVALID_BODY',
      'Request body must be a JSON object',
    );
  }

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
