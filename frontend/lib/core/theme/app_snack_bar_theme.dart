import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/app_colors.dart';

SnackBarThemeData buildSnackBarTheme({
  required ColorScheme colorScheme,
  required String paletteId,
}) {
  final isLight = colorScheme.brightness == Brightness.light;
  final isBrand = paletteId == 'brand';

  final Color backgroundColor;
  final Color foregroundColor;

  if (isBrand) {
    backgroundColor = isLight
        ? AppColors.darkBackground
        : const Color(0xFF25252C);
    foregroundColor = AppColors.textMain;
  } else {
    backgroundColor = colorScheme.inverseSurface;
    foregroundColor = colorScheme.onInverseSurface;
  }

  final borderColor = isBrand
      ? AppColors.lightPrimary.withValues(alpha: isLight ? 0.35 : 0.5)
      : colorScheme.outlineVariant.withValues(alpha: 0.6);

  return SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    elevation: isLight ? 5 : 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: borderColor),
    ),
    contentTextStyle: TextStyle(
      color: foregroundColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    actionTextColor: colorScheme.primary,
    insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
