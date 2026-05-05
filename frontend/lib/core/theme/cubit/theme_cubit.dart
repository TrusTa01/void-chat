import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/theme/palette/palette_data.dart';
import 'package:void_chat/core/theme/theme_preferences.dart';

class ThemeCubit extends Cubit<ThemePreferences> {
  ThemeCubit() : super(ThemePreferences.initial());

  void setPalette(String paletteId) =>
      emit(state.copyWith(activePaletteId: paletteId));

  void setBrightness(ThemeBrightnessPreference brightness) =>
      emit(state.copyWith(brightness: brightness));

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
          ? 'brand'
          : state.activePaletteId,
    ),
  );
}
