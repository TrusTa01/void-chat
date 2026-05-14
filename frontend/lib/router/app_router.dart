import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/layouts/app_layout.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/presentation/screens/email_confirm_screen.dart';
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
    // auth
    AutoRoute(
      path: '/auth',
      page: AuthLayoutRoute.page,
      children: [
        AutoRoute(
          path: 'login',
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(path: 'register', page: RegisterRoute.page),
        AutoRoute(path: 'email-confirm', page: EmailConfirmRoute.page),
      ],
    ),

    // app
    AutoRoute(
      path: '/app',
      page: AppLayoutRoute.page,
      initial: true,
      guards: [_authGuard],
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
