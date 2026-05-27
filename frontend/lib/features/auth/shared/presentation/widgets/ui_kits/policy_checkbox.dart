import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/constants/link_constants.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/core/utils/launcher.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/switch_link.dart';

class PolicyCheckbox extends HookWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const PolicyCheckbox({super.key, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final internalAgreed = useState(false);
    final isControlled = onChanged != null;
    final agreed = value ?? internalAgreed.value;

    void setAgreed(bool newValue) {
      if (isControlled) {
        onChanged!(newValue);
      } else {
        internalAgreed.value = newValue;
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: agreed,
          onChanged: (bool? newValue) => setAgreed(newValue ?? false),
        ),
        const SizedBox(width: 5),
        
        SwitchLink(
          text: l10n.iAgreeto,
          linkText: l10n.policy,
          onTap: () => launchMyUrl(LinkConstants.termsConditions),
        ),
      ],
    );
  }
}
