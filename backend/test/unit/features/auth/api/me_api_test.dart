import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/me/domain/use_cases/get_current_user_use_case.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeGetCurrentUserUseCase getCurrentUserUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    getCurrentUserUseCase = _FakeGetCurrentUserUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(getCurrentUser: getCurrentUserUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('GET /me', () {
    test('returns 200 with current user profile', () async {
      getCurrentUserUseCase.result = sampleLoggedInUser();

      final response = await handler(authorizedGet('/me', userId: 'user-123'));

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {
        'id': 'user-123',
        'email': 'john@example.com',
        'username': 'john_doe',
        'display_name': 'John Doe',
        'created_at': '2026-05-19T00:00:00.000Z',
      });
    });

    test('passes authenticated user id to use case', () async {
      await handler(authorizedGet('/me', userId: 'user-456'));

      expect(getCurrentUserUseCase.lastUserId, 'user-456');
      expect(getCurrentUserUseCase.callCount, 1);
    });
  });
}

final class _FakeGetCurrentUserUseCase implements IGetCurrentUserUseCase {
  UserEntity result = sampleLoggedInUser();
  String? lastUserId;
  int callCount = 0;

  @override
  Future<UserEntity> call(String userId) async {
    callCount += 1;
    lastUserId = userId;
    return result;
  }
}
