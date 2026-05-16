import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/presentation/widgets/sections/verify_form_section.dart';

@RoutePage()
class EmailConfirmScreen extends StatelessWidget {
  final String userEmail;
  final VoidCallback onVerifyPressed;

  const EmailConfirmScreen({
    super.key,
    required this.userEmail,
    required this.onVerifyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Header
    final header = AuthHeader(
      mainText: l10n.verifyEmailTitle,
      description: '${l10n.verifyEmailCodeInstruction} $userEmail',
      imageAssetPath: 'assets/images/black_hole.png',
    );

    // Body (forms)
    final body = AuthBody(
      bottomPadding: 50,
      children: [
        const VerifyFormSection(),
        const SizedBox(height: 30),

        // Verify button
        FilledButton(
          onPressed: onVerifyPressed,
          child: Text(l10n.verifyEmailSubmit),
        ),
      ],
    );

    // Footer (resend code)
    final footer = AuthFooterLink(
      text: l10n.verifyEmailDidNotReceive,
      linkText: l10n.verifyEmailResendCode,
      onTap: () {},
    );

    return AuthScaffold(header: header, body: body, footer: footer);
  }
}
