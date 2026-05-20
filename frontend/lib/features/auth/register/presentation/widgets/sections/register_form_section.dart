import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/sections/form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/password_text_form_field.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/policy_checkbox.dart';

class RegisterFormSection extends HookWidget {
  const RegisterFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
              FormSection.focusNext(context, loginFocus, passwordFocus),
          decoration: InputDecoration(
            labelText: l10n.registerLoginLabel,
            hintText: l10n.registerLoginHint,
            helperText: l10n.registerLoginPrivacyHelper,
            helperMaxLines: 3,
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => validateLoginIdentifier(value, l10n),
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
              FormSection.focusNext(context, emailFocus, loginFocus),
          decoration: InputDecoration(
            labelText: l10n.registerEmailLabel,
            hintText: l10n.registerEmailHint,
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => validateRegisterEmail(value, l10n),
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
          validator: (value) => validateLoginPassword(value, l10n),
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
          validator: (value) => validateConfirmPassword(
            value: value,
            originalPassword: passwordController.text,
            l10n: l10n,
          ),
        ),
        const SizedBox(height: 20),

        const PolicyCheckbox(),
      ],
    );
  }
}
