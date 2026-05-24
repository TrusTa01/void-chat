import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/app_colors.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';

// All built-in palettes
abstract final class BuiltInPalettes {
  // Palette color tokens

  // Brand (purple)
  static const Color _brandSeed = AppColors.primary;
  static const Color _brandLight = AppColors.lightBackground;
  static const Color _brandDark = AppColors.darkBackground;

  // Coffee (warm brown)
  static const Color _coffeeSeed = Color(0xFF795548);
  static const Color _coffeeLight = Color(0xFFF5EDE6);
  static const Color _coffeeDark = Color(0xFF221A16);

  // Ocean (sky blue)
  static const Color _oceanSeed = Color(0xFF0284C7);
  static const Color _oceanLight = Color(0xFFF0F9FF);
  static const Color _oceanDark = Color(0xFF0C1929);

  // Rose (vivid pink-red)
  static const Color _roseSeed = Color(0xFFE11D48);
  static const Color _roseLight = Color(0xFFFFF1F2);
  static const Color _roseDark = Color(0xFF1C0A0F);

  // Forest (green)
  static const Color _forestSeed = Color(0xFF16A34A);
  static const Color _forestLight = Color(0xFFF0FDF4);
  static const Color _forestDark = Color(0xFF0A1F13);

  // Palette instances
  static const brand = PaletteData(
    id: 'brand',
    name: 'Brand',
    seed: _brandSeed,
    lightBackground: _brandLight,
    darkBackground: _brandDark,
  );

  static const coffee = PaletteData(
    id: 'coffee',
    name: 'Coffee',
    seed: _coffeeSeed,
    lightBackground: _coffeeLight,
    darkBackground: _coffeeDark,
  );

  static const ocean = PaletteData(
    id: 'ocean',
    name: 'Ocean',
    seed: _oceanSeed,
    lightBackground: _oceanLight,
    darkBackground: _oceanDark,
  );

  static const rose = PaletteData(
    id: 'rose',
    name: 'Rose',
    seed: _roseSeed,
    lightBackground: _roseLight,
    darkBackground: _roseDark,
  );

  static const forest = PaletteData(
    id: 'forest',
    name: 'Forest',
    seed: _forestSeed,
    lightBackground: _forestLight,
    darkBackground: _forestDark,
  );

  static const List<PaletteData> all = [brand, coffee, ocean, rose, forest];
}

// Preset seed colors offered in the custom palette creator
abstract final class SeedColorPresets {
  static const List<Color> all = [
    Color(0xFFA855F7), // purple
    Color(0xFF6366F1), // indigo
    Color(0xFF3B82F6), // blue
    Color(0xFF0284C7), // sky
    Color(0xFF06B6D4), // cyan
    Color(0xFF14B8A6), // teal
    Color(0xFF16A34A), // green
    Color(0xFF65A30D), // lime
    Color(0xFFCA8A04), // yellow
    Color(0xFFEA580C), // orange
    Color(0xFFE11D48), // rose
    Color(0xFFEC4899), // pink
    Color(0xFF795548), // coffee
    Color(0xFF78716C), // stone
    Color(0xFF64748B), // slate
    Color(0xFF0F172A), // navy
    Color(0xFFDC2626), // red
    Color(0xFFD97706), // amber
    Color(0xFF059669), // emerald
    Color(0xFF7C3AED), // violet
  ];
}
