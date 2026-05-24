import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeStartRegistrationUseCase startRegistrationUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    startRegistrationUseCase = _FakeStartRegistrationUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(startRegistration: startRegistrationUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /register/start', () {
    test('returns 201 with registration_id', () async {
      startRegistrationUseCase.result = PendingRegistration(
        registrationId: 'registration-123',
      );

      final response = await handler(
        jsonPost('/register/start', {
          'login': 'john_doe',
          'email': 'john@example.com',
          'password': 'Password123',
        }),
      );

      expect(response.statusCode, 201);
      expect(await decodeBody(response), {
        'registration_id': 'registration-123',
      });
    });

    test('passes parsed request dto to use case', () async {
      await handler(
        jsonPost('/register/start', {
          'login': 'john_doe',
          'email': 'john@example.com',
          'password': 'Password123',
        }),
      );

      final dto = startRegistrationUseCase.lastRequest;
      expect(dto, isNotNull);
      expect(dto!.login, 'john_doe');
      expect(dto.email, 'john@example.com');
      expect(dto.password, 'Password123');
    });

    test(
      'returns INVALID_REQUEST_FIELDS when required field is missing',
      () async {
        final response = await handler(
          jsonPost('/register/start', {
            'login': 'john_doe',
            'password': 'Password123',
          }),
        );

        expect(response.statusCode, 400);
        final body = await decodeBody(response);
        expect(body['success'], false);
        expect(
          (body['error'] as Map<String, dynamic>)['code'],
          AuthErrorCodes.invalidRequestFields,
        );
        expect(startRegistrationUseCase.callCount, 0);
      },
    );

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/register/start'),
          body: jsonEncode(['not', 'an', 'object']),
          headers: {'content-type': 'application/json'},
        ),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(startRegistrationUseCase.callCount, 0);
    });
  });
}

final class _FakeStartRegistrationUseCase implements IStartRegistrationUseCase {
  PendingRegistration result = PendingRegistration(
    registrationId: 'registration-id',
  );
  StartRegistrationRequestDto? lastRequest;
  int callCount = 0;

  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) async {
    callCount += 1;
    lastRequest = data;
    return result;
  }
}
