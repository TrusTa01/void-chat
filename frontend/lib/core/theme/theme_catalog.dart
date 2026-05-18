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
      ? (isLight ? AppColors.lightInputFill : AppColors.darkInputFill)
      : (isLight ? colorScheme.surfaceContainerLow : colorScheme.surface);

  final scaffoldBg = isLight
      ? (palette.lightBackground ?? colorScheme.surface)
      : (palette.darkBackground ?? colorScheme.surface);
  final neonGlowColor = colorScheme.primary.withValues(
    alpha: isLight ? 0.68 : 0.75,
  );

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
      helperStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            backgroundColor: scaffoldBg,
            foregroundColor: colorScheme.primary,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            side: const BorderSide(color: AppColors.lightPrimary),
          ).copyWith(
            shadowColor: WidgetStatePropertyAll(neonGlowColor),
            elevation: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) return 0;
              if (states.contains(WidgetState.pressed)) return isLight ? 4 : 3;
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)) {
                return isLight ? 12 : 10;
              }
              return isLight ? 8 : 7;
            }),
          ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
        foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
        shadowColor: WidgetStatePropertyAll(neonGlowColor),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return 0;
          if (states.contains(WidgetState.pressed)) return isLight ? 4 : 3;
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return isLight ? 12 : 10;
          }
          return isLight ? 8 : 7;
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(
        color: isLight
            ? colorScheme.outline
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        width: 1.4,
      ),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.primary.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return colorScheme.primary.withValues(alpha: 0.08);
        }
        return Colors.transparent;
      }),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    primaryColor: palette.seed,
    textTheme: textTheme,
  );
}
