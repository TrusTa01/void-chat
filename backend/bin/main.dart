import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

const List<Map<String, String>> mockData = [
  {'user': 'System', 'text': 'Добро пожаловать в Void!'},
];

void main() async {
  final router = Router();

  router.get('/hello', (Request req) {
   return Response.ok(
      'Привет мир! Сервер на Shelf работает!',
      headers: {'Content-Type': 'text/plain; charset=utf-8'},
    );
  });

  router.get(
    '/messages',
    (Request req) => Response.ok(
      jsonEncode(mockData),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  router.get('/user/<name>', (Request request, String name) {
    return Response.ok(
      'Привет, $name!',
      headers: {'Content-Type': 'text/plain; charset=utf-8'},
    );
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await io.serve(handler, '0.0.0.0', 8080);
  print('🚀 Сервер запущен: http://${server.address.host}:${server.port}');
}
