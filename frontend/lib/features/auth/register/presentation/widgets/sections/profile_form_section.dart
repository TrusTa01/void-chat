import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/sections/form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/loading_button.dart';

typedef ProfileCompleteCallback =
    Future<void> Function(String username, String displayName);

class ProfileFormSection extends HookWidget {
  final ProfileCompleteCallback? onCompleteTap;
  final bool isLoading;

  const ProfileFormSection({
    super.key,
    this.onCompleteTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final exposeValidationErrors = useState(false);

    final usernameController = useTextEditingController();
    final displayNameController = useTextEditingController();

    final usernameFocus = useFocusNode();
    final displayNameFocus = useFocusNode();

    return FormSection(
      formKey: formKey,
      children: [
        TextFormField(
          controller: usernameController,
          focusNode: usernameFocus,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          autofillHints: const [AutofillHints.username],
          onFieldSubmitted: (_) =>
              FormSection.focusNext(context, usernameFocus, displayNameFocus),
          decoration: InputDecoration(
            labelText: l10n.profileSetupUsernameLabel,
            hintText: l10n.profileSetupUsernameHint,
            prefixText: '@',
          ),
          maxLines: 1,
          inputFormatters: loginIdentifierInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateLoginIdentifier(value, l10n)
              : null,
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: displayNameController,
          focusNode: displayNameFocus,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          autofillHints: const [AutofillHints.name],
          onFieldSubmitted: (_) async {
            exposeValidationErrors.value = true;
            if (!(formKey.currentState?.validate() ?? false)) return;
            await onCompleteTap?.call(
              usernameController.text.trim(),
              displayNameController.text.trim(),
            );
          },
          decoration: InputDecoration(
            labelText: l10n.profileSetupDisplayNameLabel,
            hintText: l10n.profileSetupDisplayNameHint,
          ),
          maxLines: 1,
          inputFormatters: displayNameInputFormatters,
          validator: (value) => exposeValidationErrors.value
              ? validateDisplayName(value, l10n)
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.profileSetupHintText,
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 30),

        FilledButton(
          onPressed: isLoading
              ? null
              : () async {
                  exposeValidationErrors.value = true;
                  if (!(formKey.currentState?.validate() ?? false)) return;
                  await onCompleteTap?.call(
                    usernameController.text.trim(),
                    displayNameController.text.trim(),
                  );
                },
          child: LoadingButton(
            state: isLoading,
            text: Text(l10n.completeSetup),
          ),
        ),
      ],
    );
  }
}
