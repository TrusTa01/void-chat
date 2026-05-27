import 'dart:convert';

import 'package:shelf/shelf.dart';

/// Conveniet wrapper for [Response] with content-type in header
abstract class JsonResponse {
  JsonResponse._();

  static Response ok(Object? body) => _build(200, body);
  static Response created(Object? body) => _build(201, body);
  static Response noContent() => _build(204, null);

  static Response _build(int statusCode, Object? body) => Response(
    statusCode,
    body: body == null ? null : jsonEncode(body),
    headers: {'content-type': 'application/json'},
  );
}
