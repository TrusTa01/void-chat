// import 'package:backend/src/app_module.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf_router/shelf_router.dart';
// import 'package:test/test.dart';

// import 'features/auth/api/auth_api_test_support.dart';

// void main() {
//   late Handler handler;

//   setUp(() {
//     handler = AppModule(Router(), buildTestAuthApi()).handler;
//   });

//   test('GET / returns service info', () async {
//     final response = await handler(
//       Request('GET', Uri.parse('http://localhost/')),
//     );

//     expect(response.statusCode, 200);
//     expect(response.headers['content-type'], 'application/json');
//     final body = await response.readAsString();
//     expect(body, contains('"service":"backend"'));
//     expect(body, contains('"status":"ok"'));
//   });

//   test('GET /health returns ok', () async {
//     final response = await handler(
//       Request('GET', Uri.parse('http://localhost/health')),
//     );

//     expect(response.statusCode, 200);
//     expect(await response.readAsString(), '{"status":"ok"}');
//   });

//   test('GET /favicon.ico returns 204', () async {
//     final response = await handler(
//       Request('GET', Uri.parse('http://localhost/favicon.ico')),
//     );

//     expect(response.statusCode, 204);
//   });
// }
