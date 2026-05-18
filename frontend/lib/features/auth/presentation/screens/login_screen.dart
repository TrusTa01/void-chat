import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/presentation/widgets/sections/login_form_section.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Header
    final header = AuthHeader(
      mainText: l10n.greeting,
      description: l10n.greetingDescription,
    );

    // Body (forms)
    final body = AuthBody(
      bottomPadding: 50,
      children: [
        LoginFormSection(
          onLoginTap: () {},
          onEmailConfirmTap: () => context.router.push(
            RegisterEmailConfirmRoute(userEmail: '', onVerifyPressed: () {}),
          ),
        ),
      ],
    );

    // Footer (to register screen)
    final footer = AuthFooterLink(
      text: l10n.dontHaveAcc,
      linkText: l10n.singUp,
      onTap: () => context.router.push(const RegisterRoute()),
    );

    return AuthScaffold(header: header, body: body, footer: footer);
  }
}
