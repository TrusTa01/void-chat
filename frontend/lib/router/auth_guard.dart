import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/auth/auth_cubit.dart';
import 'package:void_chat/router/app_router.dart';

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final AuthCubit _authCubit;

  AuthGuard(this._authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _authCubit.state == AuthStatus.authenticated;

    if (isAuthenticated) {
      resolver.next(true);
      return;
    }

    resolver.next(false);
    router.replaceAll([const WelcomeRoute()]);
  }
}
