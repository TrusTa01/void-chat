import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/features/auth/presentation/widgets/ui_kits/registration_step_indicator.dart';

@RoutePage()
class AuthLayoutScreen extends StatelessWidget {
  const AuthLayoutScreen({super.key});

  int? _registrationStep(RouteData route) {
    final raw = route.meta['step'];
    return raw is int ? raw : int.tryParse('$raw');
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return AutoRouter(
      builder: (context, content) {
        final canPop = context.router.canPop(ignoreParentRoutes: true);
        final step = _registrationStep(context.router.topRoute);
        const int totalSteps = 3;

        return Scaffold(
          appBar: AppBar(
            leading: canPop
                ? BackButton(onPressed: () => context.router.maybePop())
                : null,
            title: isLight
                ? Image.asset(
                    'assets/logo/logo_light.png',
                    height: 100,
                    width: 125,
                  )
                : Image.asset(
                    'assets/logo/logo_dark.png',
                    height: 100,
                    width: 125,
                  ),
            centerTitle: true,
            bottom: step != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(12),
                    child: RegistrationStepIndicator(
                      current: step,
                      total: totalSteps,
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
