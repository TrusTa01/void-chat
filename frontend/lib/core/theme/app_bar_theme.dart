import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBarTheme buildAppBarTheme({required ColorScheme colorScheme}) {
  // Match auth mockups: titles read as strong body text, not tinted primary.
  final titleColor = colorScheme.onSurface;
  final isLight = colorScheme.brightness == Brightness.light;

  return AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: titleColor,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
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
