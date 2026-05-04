import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/l10n/app_localization_setup.dart';

class VoidChat extends StatelessWidget {
  const VoidChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: AppLocalizationSetup.delegates,
      supportedLocales: AppLocalizationSetup.supportedLocales,
      locale: const Locale('en'),

      // theme
      theme: ThemeData.dark(),

      // other
      debugShowCheckedModeBanner: false,
    );
  }
}
