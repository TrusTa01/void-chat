import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/core/l10n/cubit/l10n_cubit.dart';
import 'package:void_chat/core/theme/cubit/theme_cubit.dart';
import 'package:void_chat/features/auth/presentation/cubit/auth_cubit.dart';

abstract final class AppProviders {
  static List<BlocProvider> get providers => [
    BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()..checkAuth()),
    BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>()),
    BlocProvider<L10nCubit>(create: (_) => getIt<L10nCubit>()),
  ];
}
