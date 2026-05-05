import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'l10n_state.dart';

class L10nCubit extends Cubit<L10nState> {
  L10nCubit() : super(const L10nState(locale: null));

  void setLocale(Locale locale) => emit(state.copyWith(locale: locale));
}
