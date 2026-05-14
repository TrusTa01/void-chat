import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';

class VerifyFormSection extends StatelessWidget {
  const VerifyFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
            width: 65,
            height: 65,
            textStyle: pinTextStyle,
            decoration: BoxDecoration(
              color: pinFill,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onCompleted: (_) => {},
        ),
        const SizedBox(height: 25),

        // Verify button
        FilledButton(onPressed: () {}, child: Text(l10n.verifyEmailSubmit)),
      ],
    );
  }
}
