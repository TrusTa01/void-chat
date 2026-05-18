import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/auth/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/src/features/auth/domain/usecases/login_user.dart';
import 'package:backend/src/features/auth/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/middleware/error_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  late _FakeStartRegistrationUseCase startRegistrationUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    startRegistrationUseCase = _FakeStartRegistrationUseCase();
    final api = AuthApi(
      _UnusedLoginUser(),
      _UnusedRegisterUser(),
      startRegistrationUseCase,
    );
    handler = const Pipeline()
        .addMiddleware(errorMiddleware())
        .addHandler(api.router.call);
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
        _jsonPost('/register/start', {
          'login': 'john_doe',
          'email': 'john@example.com',
          'password': 'Password123',
        }),
      );

      expect(response.statusCode, 201);
      expect(await _decodeBody(response), {
        'registration_id': 'registration-123',
      });
    });

    test('passes parsed request dto to use case', () async {
      await handler(
        _jsonPost('/register/start', {
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
          _jsonPost('/register/start', {
            'login': 'john_doe',
            'password': 'Password123',
          }),
        );

        expect(response.statusCode, 400);
        final body = await _decodeBody(response);
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
      final body = await _decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(startRegistrationUseCase.callCount, 0);
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

final class _UnusedLoginUser implements ILoginUser {
  @override
  Future<LoginResult> call(String identifier, String password) {
    throw StateError('ILoginUser should not be called in register/start tests');
  }
}

final class _UnusedRegisterUser implements IRegisterUser {
  @override
  Future<UserEntity> call(NewUser data) {
    throw StateError(
      'IRegisterUser should not be called in register/start tests',
    );
  }
}
