import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/login/presentation/extensions/login_failure_message.dart';
import 'package:void_chat/features/auth/login/presentation/widgets/sections/login_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(create: (_) => loginCubit, child: const _LoginView());
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginSuccess():
            context.router.replaceAll([const AppLayoutRoute()]);
          case LoginError(:final failure):
            context.showAppSnackBar(failure.messages(l10n));
          case LoginInitial():
          case LoginLoading():
            break;
        }
      },

      listenWhen: (previous, current) =>
          current is LoginSuccess || current is LoginError,

      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final loginCubit = context.read<LoginCubit>();

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
              isLoading: isLoading,
              onLoginTap: (identifier, password) =>
                  loginCubit.login(identifier, password),
              onEmailConfirmTap: () => context.router.push(
                EmailConfirmRoute(userEmail: '', onVerifyPressed: () {}),
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
      },
    );
  }
}
