import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';
import 'package:void_chat/core/theme/text_theme.dart';

typedef ThemePair = ({ThemeData light, ThemeData dark});

/// Builds a light/dark [ThemeData] pair from a [PaletteData]
ThemePair themePairForPalette(PaletteData palette) => (
  light: _buildTheme(palette, Brightness.light),
  dark: _buildTheme(palette, Brightness.dark),
);

ThemeData _buildTheme(PaletteData palette, Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: palette.seed,
    brightness: brightness,
  );
  final isLight = brightness == Brightness.light;
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isLight
        ? (palette.lightBackground ?? colorScheme.surface)
        : (palette.darkBackground ?? colorScheme.surface),
    dividerTheme: DividerThemeData(color: colorScheme.outlineVariant),
    primaryColor: palette.seed,
    textTheme: textTheme,
  );
}
