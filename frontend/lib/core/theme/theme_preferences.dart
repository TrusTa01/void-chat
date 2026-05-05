import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/palette/built_in_palettes.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';

enum ThemeBrightnessPreference { system, light, dark }

extension ThemeBrightnessPreferenceMapping on ThemeBrightnessPreference {
  ThemeMode get asThemeMode => switch (this) {
    ThemeBrightnessPreference.system => ThemeMode.system,
    ThemeBrightnessPreference.light => ThemeMode.light,
    ThemeBrightnessPreference.dark => ThemeMode.dark,
  };
}

final class ThemePreferences extends Equatable {
  const ThemePreferences({
    required this.activePaletteId,
    required this.brightness,
    this.customPalettes = const [],
  });

  factory ThemePreferences.initial() => const ThemePreferences(
    activePaletteId: 'brand',
    brightness: ThemeBrightnessPreference.system,
  );

  final String activePaletteId;
  final ThemeBrightnessPreference brightness;
  final List<PaletteData> customPalettes;

  List<PaletteData> get allPalettes => [
    ...BuiltInPalettes.all,
    ...customPalettes,
  ];

  PaletteData get activePalette => allPalettes.firstWhere(
    (p) => p.id == activePaletteId,
    orElse: () => BuiltInPalettes.brand,
  );

  ThemePreferences copyWith({
    String? activePaletteId,
    ThemeBrightnessPreference? brightness,
    List<PaletteData>? customPalettes,
  }) => ThemePreferences(
    activePaletteId: activePaletteId ?? this.activePaletteId,
    brightness: brightness ?? this.brightness,
    customPalettes: customPalettes ?? this.customPalettes,
  );

  @override
  List<Object?> get props => [activePaletteId, brightness, customPalettes];
}
