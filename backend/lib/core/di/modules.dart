import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:shelf_router/shelf_router.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Router get router => Router();

  @lazySingleton
  Talker get talker => Talker();

  @lazySingleton
  Pool<Connection> get pool {
    final dotEnv = dotenv.DotEnv(includePlatformEnvironment: true)..load();

    final endpoint = Endpoint(
      host: dotEnv['DB_HOST'] ?? 'localhost',
      port: int.parse(dotEnv['DB_PORT'] ?? '5432'),
      database: dotEnv['DB_NAME']!,
      username: dotEnv['DB_USER']!,
      password: dotEnv['DB_PASSWORD']!,
    );

    return Pool.withEndpoints([
      endpoint,
    ], settings: PoolSettings(maxConnectionCount: 5));
  }
}
