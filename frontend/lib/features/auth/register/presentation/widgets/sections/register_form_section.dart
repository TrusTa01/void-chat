import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/sections/form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/loading_button.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/password_text_form_field.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/policy_checkbox.dart';

typedef RegisterContinueCallback =
    Future<void> Function(String login, String email, String password);

class RegisterFormSection extends HookWidget {
  final RegisterContinueCallback? onContinueTap;
  final bool isLoading;

  const RegisterFormSection({
    super.key,
    this.onContinueTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final exposeValidationErrors = useState(false);
    final policyAgreed = useState(false);

    final emailController = useTextEditingController();
    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final emailFocus = useFocusNode();
    final loginFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    final hidePass = useState(true);

    return FormSection(
      formKey: formKey,
      children: [
        TextFormField(
          controller: loginController,
          focusNode: loginFocus,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          autofillHints: const [AutofillHints.username],
          onFieldSubmitted: (_) =>
              FormSection.focusNext(context, loginFocus, emailFocus),
          decoration: InputDecoration(
            labelText: l10n.registerLoginLabel,
            hintText: l10n.registerLoginHint,
            helperText: l10n.registerLoginPrivacyHelper,
            helperMaxLines: 3,
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateLoginIdentifier(value, l10n)
              : null,
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: emailController,
          focusNode: emailFocus,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          autofillHints: const [AutofillHints.email],
          onFieldSubmitted: (_) =>
              FormSection.focusNext(context, emailFocus, passwordFocus),
          decoration: InputDecoration(
            labelText: l10n.registerEmailLabel,
            hintText: l10n.registerEmailHint,
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateRegisterEmail(value, l10n)
              : null,
        ),
        const SizedBox(height: 20),

        PasswordTextFormField(
          controller: passwordController,
          focus: passwordFocus,
          nextFocus: confirmPasswordFocus,
          focusNext: (context, currentFocus, nextFocus) =>
              FormSection.focusNext(context, currentFocus, nextFocus),
          obscureText: hidePass.value,
          labelText: l10n.loginPasswordLabel,
          hintText: l10n.registerPasswordHint,
          onSuffixIconTap: () => hidePass.value = !hidePass.value,
          hidePass: hidePass,
          inputFormatters: loginPasswordInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateLoginPassword(value, l10n)
              : null,
        ),
        const SizedBox(height: 20),

        PasswordTextFormField(
          controller: confirmPasswordController,
          focus: confirmPasswordFocus,
          obscureText: hidePass.value,
          labelText: l10n.confirmPasswordLabel,
          hintText: l10n.registerConfirmPasswordHint,
          inputFormatters: loginPasswordInputFormatters,
          hidePass: hidePass,
          validator: (value) => exposeValidationErrors.value
              ? validateConfirmPassword(
                  value: value,
                  originalPassword: passwordController.text,
                  l10n: l10n,
                )
              : null,
        ),
        const SizedBox(height: 20),

        PolicyCheckbox(
          value: policyAgreed.value,
          onChanged: (value) => policyAgreed.value = value,
        ),
        const SizedBox(height: 30),

        FilledButton(
          onPressed: isLoading
              ? null
              : () async {
                  exposeValidationErrors.value = true;
                  if (!(formKey.currentState?.validate() ?? false)) return;
                  if (!policyAgreed.value) {
                    context.showAppSnackBar(l10n.registerPolicyRequired);
                    return;
                  }
                  await onContinueTap?.call(
                    loginController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text,
                  );
                },
          child: LoadingButton(
            state: isLoading,
            text: Text(l10n.continueAction),
          ),
        ),
      ],
    );
  }
}
