import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/l10n/app_localization_setup.dart';
import 'package:void_chat/core/theme/cubit/theme_cubit.dart';
import 'package:void_chat/core/theme/theme_catalog.dart';
import 'package:void_chat/core/theme/theme_preferences.dart';

class VoidChat extends StatelessWidget {
  const VoidChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemePreferences>(
      builder: (context, state) {
        final pair = themePairForPalette(state.activePalette);

        return MaterialApp.router(
          // locale
          onGenerateTitle: (context) => context.l10n.appTitle,
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          locale: const Locale('en'), // TODO: locale provider
          // router
          routerConfig: appRouter.config(
            navigatorObservers: () => [TalkerRouteObserver(talker)],
          ),
          // theme
          theme: pair.light,
          darkTheme: pair.dark,
          themeMode: state.brightness.asThemeMode,
          // other
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
