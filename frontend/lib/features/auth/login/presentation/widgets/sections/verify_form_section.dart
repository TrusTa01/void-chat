import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class VerifyFormSection extends StatelessWidget {
  const VerifyFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final pinFill =
        theme.inputDecorationTheme.fillColor ?? colorScheme.surfaceContainerLow;
    final pinTextStyle =
        theme.textTheme.headlineMedium?.copyWith(
          fontSize: 20,
          color: colorScheme.onSurface,
        ) ??
        TextStyle(fontSize: 20, color: colorScheme.onSurface);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Code fields
        Pinput(
          length: 4,
          keyboardType: TextInputType.number,
          separatorBuilder: (index) => const SizedBox(width: 15),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: PinTheme(
            width: 70,
            height: 70,
            textStyle: pinTextStyle,
            decoration: BoxDecoration(
              color: pinFill,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
