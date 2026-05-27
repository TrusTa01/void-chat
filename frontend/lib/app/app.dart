import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:void_chat/app/app_global_listeners.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/core/l10n/app_localization_setup.dart';
import 'package:void_chat/core/l10n/cubit/l10n_cubit.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/core/theme/cubit/theme_cubit.dart';
import 'package:void_chat/core/theme/theme_catalog.dart';
import 'package:void_chat/core/theme/theme_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.select((L10nCubit c) => c.state.locale);
    final themePrefs = context.select((ThemeCubit c) => c.state);
    final pair = themePairForPalette(themePrefs.activePalette);

    return AppGlobalListeners(
      child: MaterialApp.router(
        // locale
        onGenerateTitle: (context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizationSetup.delegates,
        supportedLocales: AppLocalizationSetup.supportedLocales,
        locale: locale,
        // router
        routerConfig: appRouter.config(
          navigatorObservers: () => [
            AutoRouteObserver(),
            TalkerRouteObserver(talker),
          ],
        ),
        // theme
        theme: pair.light,
        darkTheme: pair.dark,
        themeMode: themePrefs.brightness.asThemeMode,
        // other
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
