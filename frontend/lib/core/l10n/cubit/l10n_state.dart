part of 'l10n_cubit.dart';

final class L10nState extends Equatable {
  final Locale? locale;

  const L10nState({this.locale});

  L10nState copyWith({Locale? locale}) {
    return L10nState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
