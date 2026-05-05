import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:void_chat/core/storage/shared_preferences/prefs_keys.dart';

@lazySingleton
class AppPrefs {
  final SharedPreferences _prefs;

  AppPrefs(this._prefs);

  // locale
  String? get localeCode => _prefs.getString(PrefsKeys.localCodeKey);
  Future<void> setLocaleCode(String code) =>
      _prefs.setString(PrefsKeys.localCodeKey, code);

  // theme brightness
  String? get themeBrightness => _prefs.getString(PrefsKeys.themeBrightnessKey);
  Future<void> setThemeBrightness(String value) =>
      _prefs.setString(PrefsKeys.themeBrightnessKey, value);

  // theme pallete
  String? get themePaletteId => _prefs.getString(PrefsKeys.themePaletteIdKey);
  Future<void> setThemePaletteId(String id) =>
      _prefs.setString(PrefsKeys.themePaletteIdKey, id);
}
