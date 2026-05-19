import 'dart:convert';

import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeRequestLoginUseCase requestLoginUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    requestLoginUseCase = _FakeRequestLoginUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(requestLogin: requestLoginUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /login/code/request', () {
    test('returns 200 with sent true', () async {
      final response = await handler(
        jsonPost('/login/code/request', {'identifier': 'john@example.com'}),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {'sent': true});
    });

    test('passes identifier to use case', () async {
      await handler(
        jsonPost('/login/code/request', {'identifier': 'john@example.com'}),
      );

      expect(requestLoginUseCase.lastIdentifier, 'john@example.com');
      expect(requestLoginUseCase.callCount, 1);
    });

    test('returns INVALID_REQUEST_FIELDS when identifier is missing', () async {
      final response = await handler(
        jsonPost('/login/code/request', <String, Object?>{}),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect(
        (body['error'] as Map<String, dynamic>)['code'],
        AuthErrorCodes.invalidRequestFields,
      );
      expect(requestLoginUseCase.callCount, 0);
    });

    test('returns INVALID_BODY when JSON root is not an object', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/login/code/request'),
          body: jsonEncode(['not', 'an', 'object']),
          headers: {'content-type': 'application/json'},
        ),
      );

      expect(response.statusCode, 400);
      final body = await decodeBody(response);
      expect(body['success'], false);
      expect((body['error'] as Map<String, dynamic>)['code'], 'INVALID_BODY');
      expect(requestLoginUseCase.callCount, 0);
    });
  });
}

final class _FakeRequestLoginUseCase implements IRequestLoginUseCase {
  String? lastIdentifier;
  int callCount = 0;

  @override
  Future<void> send(String identifier) async {
    callCount += 1;
    lastIdentifier = identifier;
  }
}
