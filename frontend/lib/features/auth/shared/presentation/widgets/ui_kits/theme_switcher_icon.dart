import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/theme/cubit/theme_cubit.dart';
import 'package:void_chat/core/theme/theme_context_ext.dart';
import 'package:void_chat/core/theme/theme_preferences.dart';

class ThemeSwitcherIcon extends StatelessWidget {
  const ThemeSwitcherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final themePrefs = context.select((ThemeCubit cubit) => cubit.state);
    final isDark = context.isDark;

    return IconButton(
      onPressed: () {
        final nextBrightness =
            themePrefs.brightness == ThemeBrightnessPreference.system
            ? (isDark
                  ? ThemeBrightnessPreference.light
                  : ThemeBrightnessPreference.dark)
            : themePrefs.brightness == ThemeBrightnessPreference.light
            ? ThemeBrightnessPreference.dark
            : ThemeBrightnessPreference.light;

        context.read<ThemeCubit>().setBrightness(nextBrightness);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: Icon(
          isDark ? Icons.wb_sunny : Icons.dark_mode,
          key: ValueKey<bool>(isDark),
          color: context.colorScheme.primary,
          size: 30,
        ),
      ),
    );
  }
}
