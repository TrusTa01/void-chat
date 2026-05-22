import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/middleware/auth_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  group('authMiddleware', () {
    late int handlerCalls;

    Handler buildHandler() {
      handlerCalls = 0;
      Future<Response> inner(Request request) async {
        handlerCalls += 1;
        return Response.ok('ok');
      }

      return authMiddleware()(inner);
    }

    test('allows POST /auth/register/verify-email without token', () async {
      final handler = buildHandler();
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/auth/register/verify-email'),
        ),
      );

      expect(response.statusCode, 200);
      expect(handlerCalls, 1);
    });

    test(
      'allows POST /auth/register/verify-email/ with trailing slash',
      () async {
        final handler = buildHandler();
        final response = await handler(
          Request(
            'POST',
            Uri.parse('http://localhost/auth/register/verify-email/'),
          ),
        );

        expect(response.statusCode, 200);
        expect(handlerCalls, 1);
      },
    );

    test('requires token for GET /auth/me', () async {
      final handler = buildHandler();

      expect(
        () => handler(Request('GET', Uri.parse('http://localhost/auth/me'))),
        throwsA(isA<UnauthorizedException>()),
      );
      expect(handlerCalls, 0);
    });
  });
}
