import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_state.dart';
import 'package:void_chat/features/auth/register/presentation/extensions/register_failure_message.dart';
import 'package:void_chat/features/auth/register/presentation/widgets/sections/register_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/router/app_router.dart';
import 'package:void_chat/router/layouts/auth_layout.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (_, current) =>
          current is RegisterStarted || current is RegisterError,

      listener: (context, state) {
        switch (state) {
          case RegisterStarted(:final registrationId):
            context.showAppSnackBar(l10n.codeSent);
            context.router.push(
              RegisterEmailConfirmRoute(registrationId: registrationId),
            );
          case RegisterError(:final failure):
            if (context.router.topRoute.name != RegisterRoute.name) break;
            context.showAppSnackBar(failure.messages(l10n));
          default:
            break;
        }
      },

      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        final registerCubit = context.read<RegisterCubit>();

        final header = AuthHeader(
          mainText: l10n.createAccount,
          description: l10n.createAccountDescription,
        );

        final body = AuthBody(
          bottomPadding: 50,
          children: [
            RegisterFormSection(
              isLoading: isLoading,
              onContinueTap: (login, email, password) => registerCubit.start(
                login: login,
                email: email,
                password: password,
              ),
            ),
          ],
        );

        final footer = AuthFooterLink(
          text: l10n.alreadyHaveAnAccount,
          linkText: l10n.logIn,
          onTap: () => context.router.pop(const LoginRoute()),
        );

        return AuthScaffold(header: header, body: body, footer: footer);
      },
    );
  }
}
