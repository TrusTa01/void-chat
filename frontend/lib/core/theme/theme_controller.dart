import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ThemeController {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  void toggleTheme(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    if (themeMode.value == ThemeMode.system) {
      themeMode.value = brightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      themeMode.value = themeMode.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    }
  }
}
