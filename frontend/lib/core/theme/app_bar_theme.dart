import 'package:flutter/material.dart';

AppBarTheme buildAppBarTheme({required ColorScheme colorScheme}) {
  // Match auth mockups: titles read as strong body text, not tinted primary.
  final titleColor = colorScheme.onSurface;

  return AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: titleColor,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: titleColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
    ),
    iconTheme: IconThemeData(color: titleColor),
  );
}
