import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/core/theme/theme_context_ext.dart';
import 'package:void_chat/features/auth/register/presentation/widgets/register_profile_back_handler.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => loginCubit),
        BlocProvider(create: (_) => registerCubit),
      ],
      child: AutoRouter(
        builder: (context, content) {
          final step = _registrationStep(context.router.topRoute);

          return Scaffold(
            appBar: AppBar(
              leading: step == AppRouter.totalRegisterSteps
                  ? const RegisterProfileBackButton()
                  : const AutoLeadingButton(),
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
      ),
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
