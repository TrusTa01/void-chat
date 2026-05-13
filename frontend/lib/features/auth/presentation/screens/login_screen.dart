import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/features/auth/presentation/widgets/login_form_section.dart';
import 'package:void_chat/features/auth/presentation/widgets/switch_link.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 40),
                      child: Column(
                        children: [
                          // Main text
                          Text(
                            l10n.greeting,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Description under a main text
                          Text(
                            l10n.greetingDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Forms
                    const Padding(
                      padding: EdgeInsets.all(22),
                      child: LoginFormSection(),
                    ),
                  ],
                ),

                // to register screen
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SwitchLink(
                    text: l10n.dontHaveAcc,
                    linkText: l10n.singUp,
                    onTap: () => context.router.replace(const RegisterRoute()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
