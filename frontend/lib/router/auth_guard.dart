import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:void_chat/router/app_router.dart';

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final AuthCubit _authCubit;

  AuthGuard(this._authCubit);

  @override
  FutureOr<void> onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _authCubit.state == AuthStatus.authenticated;

    isAuthenticated ? resolver.next(true) : router.push(const LoginRoute());
  }
}
