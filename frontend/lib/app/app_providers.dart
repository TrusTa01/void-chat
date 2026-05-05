import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/l10n/cubit/l10n_cubit.dart';
import 'package:void_chat/core/theme/cubit/theme_cubit.dart';

abstract final class AppProviders {
  static List<BlocProvider> get providers => [
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
    BlocProvider<L10nCubit>(create: (_) => L10nCubit()),
  ];
}
