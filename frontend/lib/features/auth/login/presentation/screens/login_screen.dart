import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/login/presentation/extensions/login_failure_message.dart';
import 'package:void_chat/features/auth/login/presentation/widgets/sections/login_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/router/app_router.dart';
import 'package:void_chat/router/layouts/auth_layout.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          case LoginCodeSent(:final identifier):
            context.showAppSnackBar(l10n.codeSent);
            context.router.push(EmailConfirmRoute(identifier: identifier));
          case LoginCodeResent():
            context.showAppSnackBar(l10n.codeResent);
          case LoginInitial():
          case LoginLoading():
            break;
        }
      },

      listenWhen: (_, current) =>
          current is! LoginLoading && current is! LoginInitial,

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
                  loginCubit.loginWithPass(identifier, password),
              onEmailConfirmTap: (email) async =>
                  loginCubit.loginWithcode(email),
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
