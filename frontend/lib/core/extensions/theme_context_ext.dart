import 'package:flutter/material.dart';

extension ThemeContextExt on BuildContext {
  /// Theme brightness check
  bool get isLight => Theme.of(this).brightness == Brightness.light;

  /// Different variations of logo depends of theme
  String get logoPath =>
      isLight ? 'assets/logo/logo_light.png' : 'assets/logo/logo_dark.png';

  /// Convinient getter to a color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
