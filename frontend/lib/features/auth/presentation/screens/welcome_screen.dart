import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/extensions/theme_context_ext.dart';
import 'package:void_chat/features/auth/presentation/widgets/ui_kits/theme_switcher_icon.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: ThemeSwitcherIcon(),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(60),
                        child: Column(
                          children: [
                            Image.asset(
                              context.appIconLogoPath,
                              width: 200,
                              height: 200,
                            ),

                            Text(
                              l10n.appTitle,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary,
                                shadows: [
                                  Shadow(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.65),
                                    blurRadius: 12,
                                  ),
                                  Shadow(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.35),
                                    blurRadius: 28,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            StyledText(
                              text: l10n.appDescription,
                              tags: {
                                'bold': StyledTextTag(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              },
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ).copyWith(bottom: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton(
                              onPressed: () =>
                                  context.router.push(const LoginRoute()),
                              child: Text(l10n.startChatting),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
