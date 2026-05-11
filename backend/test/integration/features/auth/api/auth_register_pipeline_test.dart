import 'dart:convert';

import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/auth/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/src/features/auth/domain/usecases/login_user.dart';
import 'package:backend/src/features/auth/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

class ThrowingRegisterUser implements IRegisterUser {
  @override
  Future<UserEntity> call(NewUser data) async => call(data);
}

class ThrowingLoginUser implements ILoginUser {
  @override
  Future<LoginResult> call(String identifier, String password) async =>
      call(identifier, password);
}

Middleware testErrorMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on ValidationFailedException catch (e) {
        return _handleTestError(
          e.code,
          e.message,
          statusCode: e.statusCode,
          details: e.details,
        );
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

Response _handleTestError(
  String code,
  String message, {
  int statusCode = 400,
  List<FieldError>? details,
}) {
  final error = <String, Object?>{'code': code, 'message': message};
  if (details != null && details.isNotEmpty) {
    error['details'] = details
        .map((d) => {'field': d.field, 'code': d.code, 'message': d.message})
        .toList(growable: false);
  }
  final body = jsonEncode({'success': false, 'error': error});
  return Response(
    statusCode,
    body: body,
    headers: {'content-type': 'application/json'},
  );
}

Handler buildHandler(ILoginUser loginUseCase, IRegisterUser registerUseCase) {
  final root = Router();
  final authApi = AuthApi(loginUseCase, registerUseCase);
  root.mount('/auth/', authApi.router.call);
  return const Pipeline()
      .addMiddleware(testErrorMiddleware())
      .addHandler(root.call);
}

Request buildRequest(String body) => Request(
  'POST',
  Uri.parse('http://localhost/auth/register'),
  headers: {'content-type': 'application/json'},
  body: body,
);

void main() {
  group(
    'POST /auth/register. Users fault - invalid payload or the data doesnt pass validation',
    () {
      test('invalid payload -> 400 json error', () async {
        final handler = buildHandler(
          ThrowingLoginUser(),
          ThrowingRegisterUser(),
        );

        final request = buildRequest(
          jsonEncode({
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
        expect(body['error']['code'], 'INVALID_REQUEST_FIELDS');
      });

      test('valid payload, invalid validation -> aggregated errors', () async {
        final handler = buildHandler(
          ThrowingLoginUser(),
          ThrowingRegisterUser(),
        );

        final request = buildRequest(
          jsonEncode({
            'login': 'admin',
            'password': 'qwerty', // 6 chars, fails length
            'email': 'john@example.com',
            'username': 'jo', // 2 chars, fails length
            'display_name': 'John',
          }),
        );

        final response = await handler(request);
        final body =
            jsonDecode(await response.readAsString()) as Map<String, dynamic>;

        expect(response.statusCode, 400);
        expect(body['success'], false);
        expect(body['error']['code'], 'VALIDATION_FAILED');

        final details = body['error']['details'] as List<dynamic>;
        final fields = details
            .map((d) => (d as Map<String, dynamic>)['field'])
            .toSet();
        expect(fields, {'password', 'username'});

        final passwordError =
            details.firstWhere(
                  (d) => (d as Map<String, dynamic>)['field'] == 'password',
                )
                as Map<String, dynamic>;
        expect(passwordError['code'], 'INVALID_PASSWORD');
      });
    },
  );
}
