import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/presentation/widgets/sections/register_form_section.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Header
    final header = AuthHeader(
      mainText: l10n.createAccount,
      description: l10n.createAccountDescription,
    );

    // Body (forms)
    final body = AuthBody(
      bottomPadding: 50,
      children: [
        const RegisterFormSection(),
        const SizedBox(height: 30),

        FilledButton(
          onPressed: () =>
              context.router.push(EmailConfirmRoute(userEmail: '')),
          child: Text(l10n.continueAction),
        ),
      ],
    );

    // Footer (to login screen)
    final footer = AuthFooterLink(
      text: l10n.alreadyHaveAnAccount,
      linkText: l10n.logIn,
      onTap: () => context.router.replace(const LoginRoute()),
    );

    return AuthScaffold(header: header, body: body, footer: footer);
  }
}
