import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/chats/home_page.dart';
import 'package:void_chat/features/settings/presentation/screens/settings_screen.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: SettingsRoute.page),
  ];
}
