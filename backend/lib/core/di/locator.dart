import 'package:backend/app_module.dart';
import 'package:backend/core/di/locator.config.dart';
import 'package:backend/src/api/auth_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:talker/talker.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

Router get router => getIt<Router>();
Talker get talker => getIt<Talker>();
AppModule get appModule => getIt<AppModule>();
AuthApi get authApi => getIt<AuthApi>();
