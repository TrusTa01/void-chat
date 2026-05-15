// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppLayoutScreen]
class AppLayoutRoute extends PageRouteInfo<void> {
  const AppLayoutRoute({List<PageRouteInfo>? children})
    : super(AppLayoutRoute.name, initialChildren: children);

  static const String name = 'AppLayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppLayoutScreen();
    },
  );
}

/// generated route for
/// [AuthLayoutScreen]
class AuthLayoutRoute extends PageRouteInfo<void> {
  const AuthLayoutRoute({List<PageRouteInfo>? children})
    : super(AuthLayoutRoute.name, initialChildren: children);

  static const String name = 'AuthLayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthLayoutScreen();
    },
  );
}

/// generated route for
/// [EmailConfirmScreen]
class EmailConfirmRoute extends PageRouteInfo<EmailConfirmRouteArgs> {
  EmailConfirmRoute({
    Key? key,
    required String userEmail,
    List<PageRouteInfo>? children,
  }) : super(
         EmailConfirmRoute.name,
         args: EmailConfirmRouteArgs(key: key, userEmail: userEmail),
         initialChildren: children,
       );

  static const String name = 'EmailConfirmRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmailConfirmRouteArgs>();
      return EmailConfirmScreen(key: args.key, userEmail: args.userEmail);
    },
  );
}

class EmailConfirmRouteArgs {
  const EmailConfirmRouteArgs({this.key, required this.userEmail});

  final Key? key;

  final String userEmail;

  @override
  String toString() {
    return 'EmailConfirmRouteArgs{key: $key, userEmail: $userEmail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmailConfirmRouteArgs) return false;
    return key == other.key && userEmail == other.userEmail;
  }

  @override
  int get hashCode => key.hashCode ^ userEmail.hashCode;
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [ProfileSetupScreen]
class ProfileSetupRoute extends PageRouteInfo<void> {
  const ProfileSetupRoute({List<PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileSetupScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
