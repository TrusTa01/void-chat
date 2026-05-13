import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/app_bar_theme.dart';
import 'package:void_chat/core/theme/app_colors.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';
import 'package:void_chat/core/theme/text_theme.dart';

typedef ThemePair = ({ThemeData light, ThemeData dark});

/// Builds a light/dark [ThemeData] pair from a [PaletteData]
ThemePair themePairForPalette(PaletteData palette) => (
  light: _buildTheme(palette, Brightness.light),
  dark: _buildTheme(palette, Brightness.dark),
);

ColorScheme _brandColorScheme(ColorScheme base, bool isLight) {
  if (isLight) {
    return base.copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: AppColors.textBlack,
      onSurfaceVariant: AppColors.lightPrimary,
      surface: AppColors.lightBackground,
      surfaceContainerLow: AppColors.primary,
    );
  }
  return base.copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    onSurface: AppColors.textMain,
    onSurfaceVariant: AppColors.lightPrimary,
    surface: AppColors.primary,
    surfaceContainerLow: const Color(0xFF25252C),
  );
}

ThemeData _buildTheme(PaletteData palette, Brightness brightness) {
  final isLight = brightness == Brightness.light;
  var colorScheme = ColorScheme.fromSeed(
    seedColor: palette.seed,
    brightness: brightness,
  );

  if (palette.id == 'brand') {
    colorScheme = _brandColorScheme(colorScheme, isLight);
  }

  final inputFill = palette.id == 'brand'
      ? (isLight ? AppColors.lightOverlay : AppColors.darkInputFill)
      : (isLight ? colorScheme.surfaceContainerLow : colorScheme.surface);

  final scaffoldBg = isLight
      ? (palette.lightBackground ?? colorScheme.surface)
      : (palette.darkBackground ?? colorScheme.surface);

  return ThemeData(
    useMaterial3: true,
    fontFamily: 'SpaceGrotesk',
    appBarTheme: buildAppBarTheme(colorScheme: colorScheme),
    colorScheme: colorScheme,
    scaffoldBackgroundColor: scaffoldBg,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        // Page transitions default scrim to ColorScheme.surface; brand dark uses primary there.
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
          backgroundColor: scaffoldBg,
        ),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: ZoomPageTransitionsBuilder(
          backgroundColor: scaffoldBg,
        ),
        TargetPlatform.linux: ZoomPageTransitionsBuilder(
          backgroundColor: scaffoldBg,
        ),
        TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(
          backgroundColor: scaffoldBg,
        ),
      },
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      suffixIconColor: colorScheme.primary,
      hintStyle: TextStyle(
        color: isLight
            ? colorScheme.inverseSurface
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.55),
      ),
      labelStyle: TextStyle(
        color: isLight
            ? colorScheme.inverseSurface
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.55),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        side: const BorderSide(color: AppColors.lightPrimary),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    primaryColor: palette.seed,
    textTheme: textTheme,
  );
}
