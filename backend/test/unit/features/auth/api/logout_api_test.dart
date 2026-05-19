import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_all_use_case.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_use_case.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeLogoutUseCase logoutUseCase;
  late _FakeLogoutAllUseCase logoutAllUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    logoutUseCase = _FakeLogoutUseCase();
    logoutAllUseCase = _FakeLogoutAllUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(logout: logoutUseCase, logoutAll: logoutAllUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /logout', () {
    test('returns 200 with ok true', () async {
      final response = await handler(
        authorizedPost(
          '/logout',
          userId: 'user-123',
          token: 'my-session-token',
        ),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {'ok': true});
    });

    test('passes bearer token to use case', () async {
      await handler(
        authorizedPost(
          '/logout',
          userId: 'user-123',
          token: 'my-session-token',
        ),
      );

      expect(logoutUseCase.lastAccessToken, 'my-session-token');
      expect(logoutUseCase.callCount, 1);
      expect(logoutAllUseCase.callCount, 0);
    });
  });

  group('POST /logout/all', () {
    test('returns 200 with ok true', () async {
      final response = await handler(
        authorizedPost('/logout/all', userId: 'user-123'),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {'ok': true});
    });

    test('passes authenticated user id to use case', () async {
      await handler(authorizedPost('/logout/all', userId: 'user-456'));

      expect(logoutAllUseCase.lastUserId, 'user-456');
      expect(logoutAllUseCase.callCount, 1);
      expect(logoutUseCase.callCount, 0);
    });
  });
}

final class _FakeLogoutUseCase implements ILogoutUseCase {
  String? lastAccessToken;
  int callCount = 0;

  @override
  Future<void> call(String accessToken) async {
    callCount += 1;
    lastAccessToken = accessToken;
  }
}

final class _FakeLogoutAllUseCase implements ILogoutAllUseCase {
  String? lastUserId;
  int callCount = 0;

  @override
  Future<void> call(String userId) async {
    callCount += 1;
    lastUserId = userId;
  }
}
