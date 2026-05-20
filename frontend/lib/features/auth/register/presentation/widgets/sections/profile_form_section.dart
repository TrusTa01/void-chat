import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/login_credentials_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/sections/form_section.dart';

class ProfileFormSection extends HookWidget {
  const ProfileFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final usernameController = useTextEditingController();
    final displayNameController = useTextEditingController();

    final usernameFocus = useFocusNode();
    final displayNameFocus = useFocusNode();

    return FormSection(
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
          decoration: InputDecoration(
            labelText: l10n.profileSetupDisplayNameLabel,
            hintText: l10n.profileSetupDisplayNameHint,
          ),
          maxLines: 1,
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
      ],
    );
  }
}
