import 'package:flutter/material.dart';

class AnimatedButtonText extends StatelessWidget {
  final String text;

  const AnimatedButtonText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Text(text, key: ValueKey<String>(text)),
    );
  }
}
