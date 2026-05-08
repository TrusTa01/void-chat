import 'dart:convert';

import 'package:backend/core/di/locator.dart';
import 'package:backend/core/errors/app_exception.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

Middleware errorMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on AppException catch (e) {
        talker.warning(e);
        return _handleCustomError(e.code, e.message, statusCode: e.statusCode);
      } on FormatException catch (e) {
        talker.warning(e);
        return _handleCustomError(
          'INVALID_JSON',
          'The request body contains invalid JSON. Please check your syntax.',
          statusCode: 400,
        );
      } on ServerException catch (e, st) {
        talker.handle(e, st);
        return _handleCustomError(
          'DB_ERROR',
          'An unexpected error occurred in our database. Please try again later.',
          statusCode: 500,
        );
      } catch (e, st) {
        talker.handle(e, st);
        return _handleCustomError(
          'SERVER_ERROR',
          'Something went wrong on our end. Our engineers have been notified.',
          statusCode: 500,
        );
      }
    };
  };
}

Response _handleCustomError(
  String code,
  String message, {
  int statusCode = 400,
}) {
  final body = jsonEncode({
    'success': false,
    'error': {'code': code, 'message': message},
  });
  return Response(
    statusCode,
    body: body,
    headers: {'content-type': 'application/json'},
  );
}
