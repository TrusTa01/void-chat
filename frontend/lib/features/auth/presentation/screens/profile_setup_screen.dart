import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/presentation/widgets/sections/profile_form_section.dart';

@RoutePage()
class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Header
    final header = AuthHeader(
      mainText: l10n.profileSetupMainText,
      description: l10n.profileSetupSecondText,
    );

    // Body (forms)
    final body = AuthBody(
      children: [
        const ProfileFormSection(),
        const SizedBox(height: 30),

        // Complete setup
        FilledButton(onPressed: () {}, child: Text(l10n.completeSetup)),
      ],
    );

    return AuthScaffold(header: header, body: body);
  }
}
