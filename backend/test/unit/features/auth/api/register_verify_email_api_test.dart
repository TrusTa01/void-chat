import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/usecases/verify_email_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
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

  group('POST /register/verify-email', () {
    test('returns 200 with verified true', () async {
      final response = await handler(
        jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
          'code': '1234',
        }),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {'verified': true});
    });

    test('passes parsed registration_id and code to use case', () async {
      await handler(
        jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
          'code': '1234',
        }),
      );

      expect(verifyEmailUseCase.lastIdentifier, 'registration-123');
      expect(verifyEmailUseCase.lastCode, '1234');
      expect(verifyEmailUseCase.callCount, 1);
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          jsonPost('/register/verify-email', {'registration_id': 'id-1'}),
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
        jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
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

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/register/verify-email'),
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
