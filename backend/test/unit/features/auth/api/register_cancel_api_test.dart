import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/features/auth/register/cancel/domain/use_cases/cancel_registration_use_case.dart';
import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'auth_api_test_support.dart';

void main() {
  late _FakeCancelRegistrationUseCase cancelRegistrationUseCase;
  late Handler handler;

  setUp(() async {
    await getIt.reset();
    getIt.registerSingleton<Talker>(Talker());

    cancelRegistrationUseCase = _FakeCancelRegistrationUseCase();
    handler = createAuthHandler(
      buildTestAuthApi(cancelRegistration: cancelRegistrationUseCase),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('POST /register/cancel', () {
    test('returns 200 with cancelled true', () async {
      final response = await handler(
        jsonPost('/register/cancel', {'registration_id': 'registration-123'}),
      );

      expect(response.statusCode, 200);
      expect(await decodeBody(response), {'cancelled': true});
    });

    test('passes registration_id to use case', () async {
      await handler(
        jsonPost('/register/cancel', {'registration_id': 'registration-123'}),
      );

      expect(cancelRegistrationUseCase.lastRegistrationId, 'registration-123');
      expect(cancelRegistrationUseCase.callCount, 1);
    });
  });
}

final class _FakeCancelRegistrationUseCase implements ICancelRegistrationUseCase {
  String? lastRegistrationId;
  int callCount = 0;

  @override
  Future<void> call(String registrationId) {
    callCount += 1;
    lastRegistrationId = registrationId;
    return Future<void>.value();
  }
}
