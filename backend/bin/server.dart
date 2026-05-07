import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:backend/core/di/locator.dart';
import 'package:backend/middleware/logging_middleware.dart';

void main() async {
  await configureDependencies();

  final handler = const Pipeline()
      .addMiddleware(LoggingMiddleware.talkerMiddleware(talker))
      .addHandler(appModule.handler);

  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv6,
    8081,
    shared: true,
  );

  server.autoCompress = true;

  talker.log('Server started at http://${server.address.host}:${server.port}');
}
