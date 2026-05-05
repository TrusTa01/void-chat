import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:void_chat/core/di/locator.config.dart';
import 'package:void_chat/router/app_router.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

AppRouter get appRouter => getIt<AppRouter>();
Talker get talker => getIt<Talker>();
