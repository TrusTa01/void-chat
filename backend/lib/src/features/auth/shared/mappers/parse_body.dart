import 'dart:convert';

import 'package:backend/src/core/errors/app_exception.dart';

Map<String, dynamic> parseBody(String body) {
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

  return decoded;
}
