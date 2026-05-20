import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/core/extensions/theme_context_ext.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/registration_step_indicator.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class AuthLayoutScreen extends StatelessWidget {
  const AuthLayoutScreen({super.key});

  int? _registrationStep(RouteData route) {
    final raw = route.meta['step'];
    return raw is int ? raw : int.tryParse('$raw');
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        final step = _registrationStep(context.router.topRoute);

        return Scaffold(
          appBar: AppBar(
            leading: const AutoLeadingButton(),
            title: Image.asset(context.logoPath, height: 100, width: 125),
            centerTitle: true,
            bottom: step != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(12),
                    child: RegistrationStepIndicator(
                      current: step,
                      total: AppRouter.totalRegisterSteps,
                    ),
                  )
                : null,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: content,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AuthScaffold extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget? footer;

  const AuthScaffold({
    super.key,
    required this.header,
    required this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [header, body, ?footer],
    );
  }
}
