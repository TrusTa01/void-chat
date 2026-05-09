import 'dart:convert';

import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/features/auth/api/auth_api.dart';
import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

class ThrowingRegisterUser implements IRegisterUser {
  @override
  Future<UserEntity> call(NewUser data) async => call(data);
}

Middleware testErrorMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on AppException catch (e) {
        return _handleTestError(e.code, e.message, statusCode: e.statusCode);
      } on FormatException {
        return _handleTestError(
          'INVALID_JSON',
          'The request body contains invalid JSON. Please check your syntax.',
          statusCode: 400,
        );
      } catch (_) {
        return _handleTestError(
          'SERVER_ERROR',
          'Something went wrong on our end. Our engineers have been notified.',
          statusCode: 500,
        );
      }
    };
  };
}

Response _handleTestError(String code, String message, {int statusCode = 400}) {
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

Handler buildHandler(IRegisterUser useCase) {
  final root = Router();
  final authApi = AuthApi(useCase);
  root.mount('/auth/', authApi.router.call);
  return const Pipeline()
      .addMiddleware(testErrorMiddleware())
      .addHandler(root.call);
}

void main() {
  test('POST /auth/register invalid payload -> 400 json error', () async {
    final handler = buildHandler(ThrowingRegisterUser());

    final request = Request(
      'POST',
      Uri.parse('http://localhost/auth/register'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'login': [0],
        'password': 1,
        'email': 'john@example.com',
        'username': 'johnny',
        'display_name': 'John',
      }),
    );

    final response = await handler(request);
    final body =
        jsonDecode(await response.readAsString()) as Map<String, dynamic>;

    expect(response.statusCode, 400);
    expect(body['success'], false);
    expect(body['error']['code'], 'INVALID_FIELDS');
  });
}
