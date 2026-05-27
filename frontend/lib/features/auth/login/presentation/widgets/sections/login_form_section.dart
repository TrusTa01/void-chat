import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/sections/form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/animated_button_text.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/auth_divider.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/loading_button.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/password_text_form_field.dart';

typedef LoginSubmitPassCallback =
    Future<void> Function(String identifier, String password);

class LoginFormSection extends HookWidget {
  final ValueChanged<String>? onEmailConfirmTap;
  final LoginSubmitPassCallback? onLoginTap;
  final VoidCallback? onRecoverPasswordTap;
  final bool isLoading;

  const LoginFormSection({
    super.key,
    this.onEmailConfirmTap,
    this.onLoginTap,
    this.onRecoverPasswordTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loginFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    /// When false, validators return null so error styling is hidden (e.g. after
    /// auth stack navigation) without clearing controllers.
    final exposeValidationErrors = useState(false);

    final isPasswordMode = useState(false);
    final hidePass = useState(true);

    return FormSection(
      formKey: formKey,
      children: [
        TextFormField(
          controller: loginController,
          focusNode: loginFocus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: isPasswordMode.value
              ? TextInputAction.next
              : TextInputAction.done,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          autofillHints: const [AutofillHints.username],
          onFieldSubmitted: (_) {
            if (isPasswordMode.value) {
              FormSection.focusNext(context, loginFocus, passwordFocus);
            }
          },
          decoration: InputDecoration(
            labelText: l10n.loginOrEmailLabel,
            hintText: l10n.loginOrEmailHint,
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateLoginIdentifier(value, l10n)
              : null,
        ),
        const SizedBox(height: 20),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Align(
                alignment: Alignment.topCenter,
                heightFactor: animation.value.clamp(0.0, 1.0),
                child: child,
              ),
              child: child,
            ),
          ),

          child: isPasswordMode.value
              ? Column(
                  key: const ValueKey('password_form'),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PasswordTextFormField(
                      controller: passwordController,
                      focus: passwordFocus,
                      obscureText: hidePass.value,
                      focusNext: FormSection.focusNext,
                      labelText: l10n.loginPasswordLabel,
                      hintText: l10n.loginPasswordHint,
                      onSuffixIconTap: () => hidePass.value = !hidePass.value,
                      hidePass: hidePass,
                      inputFormatters: loginPasswordInputFormatters,
                      validator: (value) => exposeValidationErrors.value
                          ? validateLoginPassword(value, l10n)
                          : null,
                    ),

                    // 'Forgot password?' text
                    TextButton(
                      onPressed: onRecoverPasswordTap,
                      child: Text(
                        l10n.forgotPassword,
                        style: const TextStyle(),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              : const SizedBox.shrink(key: ValueKey('password_form_empty')),
        ),

        // Continue button
        FilledButton(
          onPressed: isLoading
              ? null
              : isPasswordMode.value
              ? () async {
                  exposeValidationErrors.value = true;
                  if (!(formKey.currentState?.validate() ?? false)) return;
                  await onLoginTap?.call(
                    loginController.text.trim(),
                    passwordController.text,
                  );
                }
              : () async {
                  exposeValidationErrors.value = true;
                  if (!(formKey.currentState?.validate() ?? false)) return;
                  onEmailConfirmTap?.call(loginController.text.trim());
                },
          child: LoadingButton(
            state: isLoading,
            text: AnimatedButtonText(
              text: isPasswordMode.value ? l10n.logIn : l10n.continueAction,
            ),
          ),
        ),
        const SizedBox(height: 45),

        // Divider
        AuthDivider(text: l10n.or),
        const SizedBox(height: 45),

        // Change password mode
        OutlinedButton(
          onPressed: () {
            isPasswordMode.value = !isPasswordMode.value;
            exposeValidationErrors.value = false;
            if (!isPasswordMode.value) {
              passwordController.clear();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: AnimatedButtonText(
              text: isPasswordMode.value
                  ? l10n.logInWithLogin
                  : l10n.logInWithPass,
            ),
          ),
        ),
      ],
    );
  }
}
