import 'package:flutter/material.dart';

extension ThemeContextExt on BuildContext {
  // Theme brightness check
  bool get isLight => Theme.of(this).brightness == Brightness.light;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Different variations of images depends of theme
  String get appIconLogoPath => isLight
      ? 'assets/images/logo/app_icon/app_logo_foreground_light.png'
      : 'assets/images/logo/app_icon/app_logo_foreground_dark.png';

  String get logoPath => isLight
      ? 'assets/images/logo/logo_light.png'
      : 'assets/images/logo/logo_dark.png';

  String get portalImagePath => isLight
      ? 'assets/images/portal_log_in_light.png'
      : 'assets/images/portal_log_in_dark.png';

  // Convinient getter to a color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
