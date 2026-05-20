import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool state;
  final Widget button;

  /// The imitation of loading in buttons when [state]
  const LoadingButton({super.key, required this.state, required this.button});

  @override
  Widget build(BuildContext context) => state
      ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : button;
}
