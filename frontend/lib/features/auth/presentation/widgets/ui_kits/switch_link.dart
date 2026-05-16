import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SwitchLink extends HookWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const SwitchLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final recognizer = useMemoized(() => TapGestureRecognizer(), []);
    useEffect(() => recognizer.dispose, [recognizer]);
    recognizer.onTap = onTap;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: '$text ',
        children: [
          TextSpan(
            text: linkText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500
            ),
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
