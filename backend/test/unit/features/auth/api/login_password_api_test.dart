import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeLoginPasswordUseCase loginPasswordUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    loginPasswordUseCase = _FakeLoginPasswordUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(loginPassword: loginPasswordUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /login/password', () {
    test('returns 200 with access token and user', () async {
      loginPasswordUseCase.result = sampleLoginResult();

      final response = await handler(
        jsonPost('/login/password', {
          'identifier': 'john@example.com',
          'password': 'Password123',
        }),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {
        'access_token': 'session-token-abc',
        'expires_in': Ttl.sessionTtlD30.inSeconds,
        'user': {
          'id': 'user-123',
          'email': 'john@example.com',
          'username': 'john_doe',
          'display_name': 'John Doe',
          'created_at': '2026-05-19T00:00:00.000Z',
        },
      });
    });

    test('passes identifier and password to use case', () async {
      await handler(
        jsonPost('/login/password', {
          'identifier': 'john@example.com',
          'password': 'Password123',
        }),
      );

      expect(loginPasswordUseCase.lastIdentifier, 'john@example.com');
      expect(loginPasswordUseCase.lastPassword, 'Password123');
      expect(loginPasswordUseCase.callCount, 1);
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          jsonPost('/login/password', {'identifier': 'john@example.com'}),
        );

        expect(response.statusCode, 400);
        final body = await decodeBody(response);
        expect(body['success'], false);
        expect(
          (body['error'] as Map<String, dynamic>)['code'],
          AuthErrorCodes.invalidRequestFields,
        );
        expect(loginPasswordUseCase.callCount, 0);
      },
    );

    test('returns INVALID_CREDENTIALS from use case failure', () async {
      loginPasswordUseCase.exception = const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or password is incorrect',
      );

      final response = await handler(
        jsonPost('/login/password', {
          'identifier': 'john@example.com',
          'password': 'wrong',
        }),
      );

      expect(response.statusCode, 401);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect(
        (body['error'] as Map<String, dynamic>)['code'],
        AuthErrorCodes.invalidCredentials,
      );
      expect(loginPasswordUseCase.callCount, 1);
    });

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/login/password'),
          body: jsonEncode(['not', 'an', 'object']),
          headers: {'content-type': 'application/json'},
        ),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(loginPasswordUseCase.callCount, 0);
    });
  });
}

final class _FakeLoginPasswordUseCase implements ILoginPasswordUseCase {
  LoginResult result = sampleLoginResult();
  String? lastIdentifier;
  String? lastPassword;
  int callCount = 0;
  AppException? exception;

  @override
  Future<LoginResult> call(String identifier, String password) async {
    callCount += 1;
    lastIdentifier = identifier;
    lastPassword = password;

    final e = exception;
    if (e != null) throw e;
    return result;
  }
}
