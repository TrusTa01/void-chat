import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/presentation/screens/login_screen.dart';
import 'package:void_chat/features/auth/presentation/screens/register_screen.dart';
import 'package:void_chat/features/chats/presentation/screens/home_screen.dart';
import 'package:void_chat/features/settings/presentation/screens/settings_screen.dart';
import 'package:void_chat/router/auth_guard.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard _authGuard;

  AppRouter(this._authGuard);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true, guards: [_authGuard]),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
  ];
}
