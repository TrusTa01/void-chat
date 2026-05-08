import 'package:backend/app_module.dart';
import 'package:backend/core/di/locator.config.dart';
import 'package:backend/features/auth/api/auth_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:talker/talker.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

Pool<Connection> get pool => getIt<Pool<Connection>>();
Router get router => getIt<Router>();
Talker get talker => getIt<Talker>();
AppModule get appModule => getIt<AppModule>();
AuthApi get authApi => getIt<AuthApi>();
