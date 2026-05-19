import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeCompleteRegistrationProfileUseCase completeProfileUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    completeProfileUseCase = _FakeCompleteRegistrationProfileUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(completeProfile: completeProfileUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /register/complete-profile', () {
    test('returns 201 with completed user profile', () async {
      final response = await handler(
        jsonPost('/register/complete-profile', {
          'registration_id': 'registration-123',
          'username': 'john_doe',
          'display_name': 'John Doe',
        }),
      );

      expect(response.statusCode, 201);
      expect(await decodeBody(response), {
        'id': 'user-123',
        'email': 'john@example.com',
        'username': 'john_doe',
        'display_name': 'John Doe',
        'created_at': '2026-05-19T00:00:00.000Z',
      });
    });

    test('passes parsed request dto to use case', () async {
      await handler(
        jsonPost('/register/complete-profile', {
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
          jsonPost('/register/complete-profile', {
            'registration_id': 'registration-123',
            'username': 'john_doe',
          }),
        );

        expect(response.statusCode, 400);
        final body = await decodeBody(response);
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
        jsonPost('/register/complete-profile', {
          'registration_id': 'registration-123',
          'username': 'john_doe',
          'display_name': 'John Doe',
        }),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
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
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(completeProfileUseCase.callCount, 0);
    });
  });
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
