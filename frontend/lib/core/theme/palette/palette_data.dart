import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class PaletteData extends Equatable {
  final String id;
  final String name;
  final Color seed;
  final Color? lightBackground;
  final Color? darkBackground;

  const PaletteData({
    required this.id,
    required this.name,
    required this.seed,
    this.lightBackground,
    this.darkBackground,
  });

  bool get isBuiltIn => !id.startsWith('custom_');

  PaletteData copyWith({
    String? id,
    String? name,
    Color? seed,
    Color? lightBackground,
    Color? darkBackground,
  }) => PaletteData(
    id: id ?? this.id,
    name: name ?? this.name,
    seed: seed ?? this.seed,
    lightBackground: lightBackground ?? this.lightBackground,
    darkBackground: darkBackground ?? this.darkBackground,
  );

  @override
  List<Object?> get props => [id, name, seed, lightBackground, darkBackground];
}
