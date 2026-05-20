import 'package:flutter/material.dart';

class AuthBody extends StatelessWidget {
  final List<Widget> children;
  final double? bottomPadding;

  const AuthBody({super.key, required this.children, this.bottomPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ).copyWith(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
