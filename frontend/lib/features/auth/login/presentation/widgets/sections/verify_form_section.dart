import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pinput.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/verification_code_validation.dart';

class VerifyFormSection extends HookWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onCodeCompleted;
  final GlobalKey<FormState>? formKey;
  final ValueNotifier<bool>? exposeValidationErrors;

  const VerifyFormSection({
    super.key,
    this.controller,
    this.onCodeCompleted,
    this.formKey,
    this.exposeValidationErrors,
  });

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

    final internalFormKey = useMemoized(GlobalKey<FormState>.new);
    final formKey = this.formKey ?? internalFormKey;
    final internalExposeErrors = useState(false);
    final exposeErrors = exposeValidationErrors ?? internalExposeErrors;

    final internalController = useTextEditingController();
    final controller = this.controller ?? internalController;

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: pinTextStyle,
      decoration: BoxDecoration(
        color: pinFill,
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: colorScheme.error),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Pinput(
            length: verificationCodeLength,
            keyboardType: TextInputType.number,
            controller: controller,
            separatorBuilder: (index) => const SizedBox(width: 15),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            defaultPinTheme: defaultPinTheme,
            errorPinTheme: errorPinTheme,
            validator: (value) => exposeErrors.value
                ? validateVerificationCode(value, l10n)
                : null,
            onCompleted: (code) {
              exposeErrors.value = true;
              if (validateVerificationCode(code, l10n) == null) {
                onCodeCompleted?.call(code);
              } else {
                formKey.currentState?.validate();
              }
            },
          ),
        ],
      ),
    );
  }
}
