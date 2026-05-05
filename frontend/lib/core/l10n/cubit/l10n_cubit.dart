import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/storage/shared_preferences/app_prefs.dart';

part 'l10n_state.dart';

@injectable
class L10nCubit extends Cubit<L10nState> {
  final AppPrefs _prefs;

  L10nCubit(this._prefs) : super(const L10nState(locale: null)) {
    _restore();
  }

  Future<void> _restore() async {
    final code = _prefs.localeCode;
    if (code != null) emit(state.copyWith(locale: Locale(code)));
  }

  Future<void> setLocale(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await _prefs.setLocaleCode(locale.languageCode);
  }
}
