import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/presentation/screens/email_confirm_screen.dart';
import 'package:void_chat/features/auth/login/presentation/screens/login_screen.dart';
import 'package:void_chat/features/auth/register/presentation/screens/profile_setup_screen.dart';
import 'package:void_chat/features/auth/register/presentation/screens/register_email_confirm_screen.dart';
import 'package:void_chat/features/auth/register/presentation/screens/register_screen.dart';
import 'package:void_chat/features/auth/shared/presentation/screens/welcome_screen.dart';
import 'package:void_chat/features/home/presentation/screens/home_screen.dart';
import 'package:void_chat/router/auth_guard.dart';
import 'package:void_chat/router/layouts/app_layout.dart';
import 'package:void_chat/router/layouts/auth_layout.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard _authGuard;

  AppRouter(this._authGuard);

  static const int totalRegisterSteps = 3;

  @override
  List<AutoRoute> get routes => [
    // initial screen (welcome)
    AutoRoute(path: '/welcome', page: WelcomeRoute.page, initial: true),

    // auth
    AutoRoute(
      path: '/auth',
      page: AuthLayoutRoute.page,
      children: [
        // login
        AutoRoute(path: 'login', page: LoginRoute.page, initial: true),
        AutoRoute(
          path: 'login-email-confirm',
          page: EmailConfirmRoute.page,
        ),

        // register
        AutoRoute(
          path: 'register',
          meta: {'step': 1},
          page: RegisterRoute.page,
        ),
        AutoRoute(
          path: 'register-email-confirm',
          meta: {'step': 2},
          page: RegisterEmailConfirmRoute.page,
        ),
        AutoRoute(
          path: 'profile-setup',
          meta: {'step': 3},
          page: ProfileSetupRoute.page,
        ),
      ],
    ),

    // app
    AutoRoute(
      path: '/app',
      page: AppLayoutRoute.page,
      guards: [_authGuard],
      children: [AutoRoute(page: HomeRoute.page, initial: true)],
    ),
  ];
}
