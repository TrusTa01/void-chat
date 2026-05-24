import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/storage/shared_preferences/app_prefs.dart';
import 'package:void_chat/core/theme/palette/built_in_palettes.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';
import 'package:void_chat/core/theme/theme_preferences.dart';

@injectable
class ThemeCubit extends Cubit<ThemePreferences> {
  final AppPrefs _prefs;

  ThemeCubit(this._prefs) : super(ThemePreferences.initial()) {
    _restore();
  }

  Future<void> _restore() async {
    final brightnessRaw = _prefs.themeBrightness;
    final paletteId = _prefs.themePaletteId;

    ThemeBrightnessPreference brightness = ThemeBrightnessPreference.system;

    if (brightnessRaw != null) {
      try {
        brightness = ThemeBrightnessPreference.values.byName(brightnessRaw);
      } catch (_) {
        brightness = ThemeBrightnessPreference.system;
      }
    }
    
    emit(
      state.copyWith(
        brightness: brightness,
        activePaletteId: paletteId ?? state.activePaletteId,
      ),
    );
  }

  Future<void> setPalette(String paletteId) async {
    emit(state.copyWith(activePaletteId: paletteId));
    await _prefs.setThemePaletteId(paletteId);
  }

  Future<void> setBrightness(ThemeBrightnessPreference brightness) async {
    emit(state.copyWith(brightness: brightness));
    await _prefs.setThemeBrightness(brightness.name);
  }

  void addCustomPalette(PaletteData palette) => emit(
    state.copyWith(
      customPalettes: [...state.customPalettes, palette],
      activePaletteId: palette.id,
    ),
  );

  void removeCustomPalette(String id) => emit(
    state.copyWith(
      customPalettes: state.customPalettes.where((p) => p.id != id).toList(),
      activePaletteId: state.activePaletteId == id
          ? BuiltInPalettes.all.first.id
          : state.activePaletteId,
    ),
  );
}
