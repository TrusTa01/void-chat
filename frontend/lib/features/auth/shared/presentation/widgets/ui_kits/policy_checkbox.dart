import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/constants/link_constants.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/utils/launcher.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/switch_link.dart';

class PolicyCheckbox extends HookWidget {
  const PolicyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isAgreed = useState(false);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Checkbox
        Checkbox(
          value: isAgreed.value,
          onChanged: (bool? newValue) => isAgreed.value = newValue ?? false,
        ),
        const SizedBox(width: 5),

        // Text
        SwitchLink(
          text: l10n.iAgreeto,
          linkText: l10n.policy,
          onTap: () => launchMyUrl(LinkConstants.termsConditions),
        ),
      ],
    );
  }
}
