import 'package:flutter/material.dart';

// Shared typography definition. Colors are intentionally omitted so M3
// colorScheme governs text colors per-brightness automatically
const textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
  labelSmall: TextStyle(fontSize: 12),
);
