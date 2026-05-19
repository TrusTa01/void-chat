import 'package:backend/src/middleware/auth_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  Handler publicHandler() =>
      (Request request) => Response.ok(request.url.path);

  Handler pipeline() =>
      Pipeline().addMiddleware(authMiddleware()).addHandler(publicHandler());

  group('public paths without token', () {
    for (final path in ['/', '/health', '/favicon.ico']) {
      test('GET $path', () async {
        final response = await pipeline()(
          Request('GET', Uri.parse('http://localhost$path')),
        );

        expect(response.statusCode, 200);
      });
    }

    test('GET /health/ (trailing slash)', () async {
      final response = await pipeline()(
        Request('GET', Uri.parse('http://localhost/health/')),
      );

      expect(response.statusCode, 200);
    });
  });

  test('protected path without token returns 401', () async {
    expect(
      () => pipeline()(Request('GET', Uri.parse('http://localhost/auth/me'))),
      throwsA(isA<Exception>()),
    );
  });
}
