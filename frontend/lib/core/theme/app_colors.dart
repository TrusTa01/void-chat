import 'package:flutter/material.dart';

abstract final class AppColors {
  // main accent
  static const Color primary = Color(0xFF9A64FF);
  static const Color lightPrimary = Color(0xFFBB9AFF);

  // backgrounds
  static const Color darkBackground = Color(0xFF1A1A1E);
  static const Color lightBackground = Color(0xFFFFFFFF);

  // form fields
  static const Color darkInputFill = Color.fromARGB(255, 40, 38, 43);
  static const Color lightInputFill = Color(0xFFAFA9B6);

  // layers
  static const Color surface = Color(0xFF0A0A0A);
  static const Color darkOverlay = Color(0xFF000000);
  static const Color lightOverlay = Color(0xFFCBC4D2);

  // text
  static const Color textMain = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF8E8E93);
  static const Color textBlack = Color(0xFF000000);
}
