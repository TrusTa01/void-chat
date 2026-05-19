import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/middleware/error_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  late _FakeVerifyRegistrationEmailUseCase verifyEmailUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    verifyEmailUseCase = _FakeVerifyRegistrationEmailUseCase();
    final api = AuthApi(
      _UnusedLoginUser(),
      _UnusedCompleteRegistrationProfileUseCase(),
      _UnusedStartRegistrationUseCase(),
      verifyEmailUseCase,
    );
    handler = const Pipeline()
        .addMiddleware(errorMiddleware())
        .addHandler(api.router.call);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /register/verify-email', () {
    test('returns 200 with verified true', () async {
      final response = await handler(
        _jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
          'code': '1234',
        }),
      );

      expect(response.statusCode, 200);
      expect(await _decodeBody(response), {'verified': true});
    });

    test('passes parsed registration_id and code to use case', () async {
      await handler(
        _jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
          'code': '1234',
        }),
      );

      expect(verifyEmailUseCase.lastRegistrationId, 'registration-123');
      expect(verifyEmailUseCase.lastCode, '1234');
      expect(verifyEmailUseCase.callCount, 1);
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          _jsonPost('/register/verify-email', {'registration_id': 'id-1'}),
        );

        expect(response.statusCode, 400);
        final body = await _decodeBody(response);
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
        _jsonPost('/register/verify-email', {
          'registration_id': 'registration-123',
          'code': '0000',
        }),
      );

      expect(response.statusCode, 400);
      final body = await _decodeBody(response);
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
      final body = await _decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(verifyEmailUseCase.callCount, 0);
    });
  });
}

Request _jsonPost(String path, Map<String, Object?> body) {
  return Request(
    'POST',
    Uri.parse('http://localhost$path'),
    body: jsonEncode(body),
    headers: {'content-type': 'application/json'},
  );
}

Future<Map<String, dynamic>> _decodeBody(Response response) async {
  return jsonDecode(await response.readAsString()) as Map<String, dynamic>;
}

final class _FakeVerifyRegistrationEmailUseCase
    implements IVerifyRegistrationEmailUseCase {
  String? lastRegistrationId;
  String? lastCode;
  int callCount = 0;
  AppException? exception;

  @override
  Future<void> call({required String registrationId, required String code}) {
    callCount += 1;
    lastRegistrationId = registrationId;
    lastCode = code;

    final e = exception;
    if (e != null) throw e;
    return Future<void>.value();
  }
}

final class _UnusedStartRegistrationUseCase
    implements IStartRegistrationUseCase {
  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) {
    throw StateError(
      'IStartRegistrationUseCase should not be called in register/verify-email tests',
    );
  }
}

final class _UnusedLoginUser implements ILoginUser {
  @override
  Future<LoginResult> call(String identifier, String password) {
    throw StateError(
      'ILoginUser should not be called in register/verify-email tests',
    );
  }
}

final class _UnusedCompleteRegistrationProfileUseCase
    implements ICompleteRegistrationProfileUseCase {
  @override
  Future<UserEntity> call(CompleteProfileRequestDto data) {
    throw StateError(
      'ICompleteRegistrationProfileUseCase should not be called in register/verify-email tests',
    );
  }
}
