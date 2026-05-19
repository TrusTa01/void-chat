import 'dart:async';
import 'dart:io';

import 'package:backend/src/middleware/auth_middleware.dart';
import 'package:backend/src/middleware/error_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/middleware/logging_middleware.dart';
import 'package:postgres/postgres.dart';

Future<void> main() async {
  HttpServer? server;
  Pool<Connection>? dbPool;
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8082;

  try {
    // di
    await configureDependencies();

    // db
    dbPool = pool;
    talker.info('Database pool initialized');

    // http pipeline
    final handler = const Pipeline()
        .addMiddleware(LoggingMiddleware.talkerMiddleware(talker))
        .addMiddleware(authMiddleware())
        .addMiddleware(errorMiddleware())
        .addHandler(appModule.handler);

    // server
    server = await shelf_io.serve(
      handler,
      InternetAddress.anyIPv4,
      port,
      shared: false,
    );
    server.autoCompress = true;
    final bindHost = server.address.host;
    final publicHost =
        (bindHost == InternetAddress.anyIPv4.host ||
            bindHost == InternetAddress.anyIPv6.host)
        ? 'localhost'
        : bindHost;
    talker.info(
      'Server started successfuly! \npublic host: http://$publicHost:${server.port}\nserver host: http://${server.address.host}:${server.port}',
    );

    // graceful shutdown
    final stop = Completer<void>();

    Future<void> shutDown(String signal) async {
      if (stop.isCompleted) return;
      talker.warning('Received $signal, shutting down...');
      await server?.close(force: false);
      await dbPool?.close();
      stop.complete();
    }

    ProcessSignal.sigint.watch().listen((_) => shutDown('SIGINT'));
    if (!Platform.isWindows) {
      ProcessSignal.sigterm.watch().listen((_) => shutDown('SIGTERM'));
    } else {
      talker.warning('SIGTERM is not supported on Windows, SIGINT only');
    }

    await stop.future;
    talker.info('Shutdown complete');
  } catch (e, st) {
    talker.handle(e, st, 'Fatal startup error');
    await server?.close(force: true);
    await dbPool?.close();
    exitCode = 1;
  }
}
