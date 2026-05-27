import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/login/presentation/extensions/login_failure_message.dart';
import 'package:void_chat/features/auth/login/presentation/widgets/sections/verify_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/hooks/use_email_code_resend_cooldown.dart';
import 'package:void_chat/features/auth/shared/presentation/validation/verification_code_validation.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/loading_button.dart';
import 'package:void_chat/router/app_router.dart';
import 'package:void_chat/router/layouts/auth_layout.dart';

@RoutePage()
class EmailConfirmScreen extends HookWidget {
  final String identifier;

  const EmailConfirmScreen({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final pinController = useTextEditingController();
    useListenable(pinController);
    final resendCooldown = useEmailCodeResendCooldown();

    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (_, current) =>
          current is LoginCodeResent ||
          current is LoginError ||
          current is LoginSuccess,

      listener: (context, state) {
        switch (state) {
          case LoginCodeResent():
            context.showAppSnackBar(l10n.codeResent);
            resendCooldown.startCooldown();
            pinController.clear();
          case LoginError(:final failure):
            context.showAppSnackBar(failure.messages(l10n));
            if (failure is ResendTooSoonFailure) {
              resendCooldown.startCooldown();
            }
          case LoginSuccess():
            context.router.replaceAll([const AppLayoutRoute()]);
          default:
            break;
        }
      },

      builder: (context, state) {
        final isLoading = state is LoginLoading;

        // Header
        final header = AuthHeader(
          mainText: l10n.verifyEmailTitle,
          description: '${l10n.verifyEmailCodeInstruction} $identifier',
          imageAssetPath: 'assets/images/black_hole.png',
          imageBoxShadow: (alpha: 0.6, blurRadius: 20, spreadRadius: 1),
        );

        // Body (forms)
        final body = AuthBody(
          bottomPadding: 50,
          children: [
            VerifyFormSection(
              controller: pinController,
            ),
            const SizedBox(height: 30),

            // Verify button
            FilledButton(
              onPressed:
                  isLoading ||
                      pinController.text.length != verificationCodeLength
                  ? null
                  : () async {
                      await context.read<LoginCubit>().verifyCode(
                        identifier,
                        pinController.text.trim(),
                      );
                    },
              child: LoadingButton(
                state: isLoading,
                text: Text(l10n.verifyEmailSubmit),
              ),
            ),
          ],
        );

        // Footer (resend code)
        final footer = AuthFooterLink(
          text: l10n.verifyEmailDidNotReceive,
          linkText: resendCooldown.canResend
              ? l10n.verifyEmailResendCode
              : '${l10n.verifyEmailResendCode} (${resendCooldown.secondsLeft})',
          onTap: (isLoading || !resendCooldown.canResend)
              ? () {}
              : () => context.read<LoginCubit>().resendCode(identifier),
        );

        return AuthScaffold(header: header, body: body, footer: footer);
      },
    );
  }
}
