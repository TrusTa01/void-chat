import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/usecases/verify_email_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeVerifyEmailUseCase verifyEmailUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    verifyEmailUseCase = _FakeVerifyEmailUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(verifyEmail: verifyEmailUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /login/code/verify', () {
    test('returns 200 with access token and user', () async {
      verifyEmailUseCase.result = sampleLoginResult();

      final response = await handler(
        jsonPost('/login/code/verify', {
          'identifier': 'john@example.com',
          'code': '1234',
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

    test('passes identifier and code to use case', () async {
      await handler(
        jsonPost('/login/code/verify', {
          'identifier': 'john@example.com',
          'code': '1234',
        }),
      );

      expect(verifyEmailUseCase.lastIdentifier, 'john@example.com');
      expect(verifyEmailUseCase.lastCode, '1234');
      expect(verifyEmailUseCase.callCount, 1);
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          jsonPost('/login/code/verify', {'identifier': 'john@example.com'}),
        );

        expect(response.statusCode, 400);
        final body = await decodeBody(response);
        expect(body['success'], false);
        expect(
          (body['error'] as Map<String, dynamic>)['code'],
          AuthErrorCodes.invalidRequestFields,
        );
        expect(verifyEmailUseCase.callCount, 0);
      },
    );

    test('returns INVALID_EMAIL_CODE from use case failure', () async {
      verifyEmailUseCase.exception = const ValidationException(
        AuthErrorCodes.invalidEmailCode,
        'Email verification code is invalid',
      );

      final response = await handler(
        jsonPost('/login/code/verify', {
          'identifier': 'john@example.com',
          'code': '0000',
        }),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect(
        (body['error'] as Map<String, dynamic>)['code'],
        AuthErrorCodes.invalidEmailCode,
      );
      expect(verifyEmailUseCase.callCount, 1);
    });

    test('returns INVALID_CREDENTIALS from use case failure', () async {
      verifyEmailUseCase.exception = const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or code is incorrect',
      );

      final response = await handler(
        jsonPost('/login/code/verify', {
          'identifier': 'unknown@example.com',
          'code': '1234',
        }),
      );

      expect(response.statusCode, 401);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect(
        (body['error'] as Map<String, dynamic>)['code'],
        AuthErrorCodes.invalidCredentials,
      );
      expect(verifyEmailUseCase.callCount, 1);
    });

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/login/code/verify'),
          body: jsonEncode(['not', 'an', 'object']),
          headers: {'content-type': 'application/json'},
        ),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(verifyEmailUseCase.callCount, 0);
    });
  });
}

final class _FakeVerifyEmailUseCase implements IVerifyEmailUseCase {
  LoginResult result = sampleLoginResult();
  String? lastIdentifier;
  String? lastCode;
  int callCount = 0;
  AppException? exception;

  @override
  Future<LoginResult> verify({
    required String identifier,
    required String code,
  }) async {
    callCount += 1;
    lastIdentifier = identifier;
    lastCode = code;

    final e = exception;
    if (e != null) throw e;
    return result;
  }
}
