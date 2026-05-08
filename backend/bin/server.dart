import 'dart:async';
import 'dart:io';

import 'package:backend/middleware/error_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:backend/core/di/locator.dart';
import 'package:backend/middleware/logging_middleware.dart';
import 'package:postgres/postgres.dart';

Future<void> main() async {
  HttpServer? server;
  Pool<Connection>? dbPool;

  try {
    // di
    await configureDependencies();

    // db
    dbPool = pool;
    talker.info('Database pool initialized');

    // http pipeline
    final handler = const Pipeline()
        .addMiddleware(LoggingMiddleware.talkerMiddleware(talker))
        .addMiddleware(errorMiddleware())
        .addHandler(appModule.handler);

    // server
    server = await shelf_io.serve(
      handler,
      InternetAddress.anyIPv6,
      8081,
      shared: true,
    );
    server.autoCompress = true;
    talker.info(
      'Server started at http://${server.address.host}:${server.port}',
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
    ProcessSignal.sigterm.watch().listen((_) => shutDown('SIGTERM'));

    await stop.future;
    talker.info('Shutdown complete');
  } catch (e, st) {
    talker.handle(e, st, 'Fatal startup error');
    await server?.close(force: true);
    await dbPool?.close();
    exitCode = 1;
  }
}
