import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/app_colors.dart';

const primaryColor = AppColors.primary;

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.darkBackground,
  dividerTheme: const DividerThemeData(color: AppColors.lightOverlay),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  ),
  primaryColor: primaryColor,
  textTheme: textTheme,
);

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.lightBackground,
  dividerTheme: const DividerThemeData(color: AppColors.darkOverlay),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ),
  primaryColor: primaryColor,
  textTheme: textTheme,
);

const textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  headlineMedium: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
  ),
  labelSmall: TextStyle(fontSize: 12, color: Colors.grey),
);
