import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        actions: [const ThemeSwitcherIcon(), const SizedBox(width: 15)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(context.logoPath, width: 100, height: 100),
              const SizedBox(height: 10),

              Text(l10n.appTitle),

              TextButton(
                onPressed: () => context.router.push(const LoginRoute()),
                child: const Text('to login screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
