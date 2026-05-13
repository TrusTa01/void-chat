import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/features/auth/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/presentation/widgets/animated_button_text.dart';
import 'package:void_chat/features/auth/presentation/widgets/policy_checkbox.dart';
import 'package:void_chat/router/app_router.dart';

class RegisterFormSection extends HookWidget {
  const RegisterFormSection({super.key});

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final loginFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    /// When false, validators return null so error styling is hidden (e.g. after
    /// auth stack navigation) without clearing controllers.
    final exposeValidationErrors = useState(false);

    final hidePass = useState(true);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: loginController,
            focusNode: loginFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            autofillHints: const [AutofillHints.username],
            onFieldSubmitted: (_) =>
                _fieldFocusChange(context, loginFocus, passwordFocus),
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

          TextFormField(
            controller: passwordController,
            focusNode: passwordFocus,
            obscureText: hidePass.value,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) =>
                _fieldFocusChange(context, passwordFocus, confirmPasswordFocus),
            decoration: InputDecoration(
              labelText: l10n.loginPasswordLabel,
              hintText: l10n.loginPasswordHint,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () => hidePass.value = !hidePass.value,
                  icon: Icon(
                    hidePass.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            maxLines: 1,
            inputFormatters: loginPasswordInputFormatters,
            validator: (value) => exposeValidationErrors.value
                ? validateLoginPassword(value, l10n)
                : null,
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocus,
            obscureText: hidePass.value,
            textInputAction: TextInputAction.done,
            enableInteractiveSelection: false,
            autofillHints: const [AutofillHints.newPassword],
            decoration: InputDecoration(
              labelText: l10n.confirmPasswordLabel,
              hintText: l10n.confirmPasswordHint,
            ),
            maxLines: 1,
            inputFormatters: loginPasswordInputFormatters,
            validator: (value) => exposeValidationErrors.value
                ? validateConfirmPassword(
                    value: value,
                    originalPassword: passwordController.text,
                    l10n: l10n,
                  )
                : null,
          ),
          const SizedBox(height: 20),

          const PolicyCheckbox(),
          const SizedBox(height: 50),

          // Continue button
          FilledButton(
            onPressed: () => context.router.push(const EmailConfirmRoute()),
            child: AnimatedButtonText(text: l10n.continueAction),
          ),
        ],
      ),
    );
  }
}
