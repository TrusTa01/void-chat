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
  late _FakeCompleteRegistrationProfileUseCase completeProfileUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    completeProfileUseCase = _FakeCompleteRegistrationProfileUseCase();
    final api = AuthApi(
      _UnusedLoginUser(),
      completeProfileUseCase,
      _UnusedStartRegistrationUseCase(),
      _UnusedVerifyRegistrationEmailUseCase(),
    );
    handler = const Pipeline()
        .addMiddleware(errorMiddleware())
        .addHandler(api.router.call);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /register/complete-profile', () {
    test('returns 201 with completed user profile', () async {
      final response = await handler(
        _jsonPost('/register/complete-profile', {
          'registration_id': 'registration-123',
          'username': 'john_doe',
          'display_name': 'John Doe',
        }),
      );

      expect(response.statusCode, 201);
      expect(await _decodeBody(response), {
        'id': 'user-123',
        'email': 'john@example.com',
        'username': 'john_doe',
        'display_name': 'John Doe',
        'created_at': '2026-05-19T00:00:00.000Z',
      });
    });

    test('passes parsed request dto to use case', () async {
      await handler(
        _jsonPost('/register/complete-profile', {
          'registration_id': 'registration-123',
          'username': 'john_doe',
          'display_name': 'John Doe',
        }),
      );

      final dto = completeProfileUseCase.lastRequest;
      expect(dto, isNotNull);
      expect(dto!.registrationId, 'registration-123');
      expect(dto.username, 'john_doe');
      expect(dto.displayName, 'John Doe');
      expect(completeProfileUseCase.callCount, 1);
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          _jsonPost('/register/complete-profile', {
            'registration_id': 'registration-123',
            'username': 'john_doe',
          }),
        );

        expect(response.statusCode, 400);
        final body = await _decodeBody(response);
        expect(body['success'], false);
        expect(
          (body['error'] as Map<String, dynamic>)['code'],
          AuthErrorCodes.invalidRequestFields,
        );
        expect(completeProfileUseCase.callCount, 0);
      },
    );

    test('returns EMAIL_NOT_VERIFIED from use case failure', () async {
      completeProfileUseCase.exception = const ValidationException(
        AuthErrorCodes.emailNotVerified,
        'Email must be verified before completing profile',
      );

      final response = await handler(
        _jsonPost('/register/complete-profile', {
          'registration_id': 'registration-123',
          'username': 'john_doe',
          'display_name': 'John Doe',
        }),
      );

      expect(response.statusCode, 400);
      final body = await _decodeBody(response);
      expect(body['success'], false);
      expect(
        (body['error'] as Map<String, dynamic>)['code'],
        AuthErrorCodes.emailNotVerified,
      );
      expect(completeProfileUseCase.callCount, 1);
    });

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/register/complete-profile'),
          body: jsonEncode(['not', 'an', 'object']),
          headers: {'content-type': 'application/json'},
        ),
      );

      expect(response.statusCode, 400);
      final body = await _decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(completeProfileUseCase.callCount, 0);
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

final class _FakeCompleteRegistrationProfileUseCase
    implements ICompleteRegistrationProfileUseCase {
  CompleteProfileRequestDto? lastRequest;
  int callCount = 0;
  AppException? exception;
  UserEntity result = DateTime.parse('2026-05-19T00:00:00Z').let(
    (createdAt) => UserEntity(
      id: 'user-123',
      email: 'john@example.com',
      username: 'john_doe',
      displayName: 'John Doe',
      createdAt: createdAt,
    ),
  );

  @override
  Future<UserEntity> call(CompleteProfileRequestDto data) {
    callCount += 1;
    lastRequest = data;

    final e = exception;
    if (e != null) throw e;
    return Future.value(result);
  }
}

extension _Let<T extends Object> on T {
  R let<R>(R Function(T value) transform) => transform(this);
}

final class _UnusedStartRegistrationUseCase
    implements IStartRegistrationUseCase {
  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) {
    throw StateError(
      'IStartRegistrationUseCase should not be called in register/complete-profile tests',
    );
  }
}

final class _UnusedVerifyRegistrationEmailUseCase
    implements IVerifyRegistrationEmailUseCase {
  @override
  Future<void> call({required String registrationId, required String code}) {
    throw StateError(
      'IVerifyRegistrationEmailUseCase should not be called in register/complete-profile tests',
    );
  }
}

final class _UnusedLoginUser implements ILoginUser {
  @override
  Future<LoginResult> call(String identifier, String password) {
    throw StateError(
      'ILoginUser should not be called in register/complete-profile tests',
    );
  }
}
