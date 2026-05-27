import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/login/presentation/widgets/sections/verify_form_section.dart';
import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_state.dart';
import 'package:void_chat/features/auth/register/presentation/extensions/register_failure_message.dart';
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
class RegisterEmailConfirmScreen extends HookWidget {
  final String registrationId;

  const RegisterEmailConfirmScreen({super.key, required this.registrationId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final registerCubit = context.read<RegisterCubit>();

    final pinController = useTextEditingController();
    useListenable(pinController);
    final resendCooldown = useEmailCodeResendCooldown();

    final email = registerCubit.draftEmail ?? '';

    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (_, current) =>
          current is! RegisterLoading && current is! RegisterInitial,

      listener: (context, state) {
        switch (state) {
          case RegisterCodeResent():
            context.showAppSnackBar(l10n.codeResent);
            resendCooldown.startCooldown();
            pinController.clear();
          case RegisterError(:final failure):
            context.showAppSnackBar(failure.messages(l10n));
            if (failure is RegisterResendTooSoonFailure) {
              resendCooldown.startCooldown();
            }
          case RegisterEmailVerified():
            context.router.push(const ProfileSetupRoute());
          default:
            break;
        }
      },

      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        final header = AuthHeader(
          mainText: l10n.verifyEmailTitle,
          description: '${l10n.verifyEmailCodeInstruction} $email',
          imageAssetPath: 'assets/images/black_hole.png',
          imageBoxShadow: (alpha: 0.6, blurRadius: 20, spreadRadius: 1),
        );

        final body = AuthBody(
          bottomPadding: 50,
          children: [
            VerifyFormSection(
              controller: pinController,
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed:
                  isLoading ||
                      pinController.text.length != verificationCodeLength
                  ? null
                  : () => registerCubit.verifyEmail(pinController.text.trim()),
              child: LoadingButton(
                state: isLoading,
                text: Text(l10n.verifyEmailSubmit),
              ),
            ),
          ],
        );

        final footer = AuthFooterLink(
          text: l10n.verifyEmailDidNotReceive,
          linkText: resendCooldown.canResend
              ? l10n.verifyEmailResendCode
              : '${l10n.verifyEmailResendCode} (${resendCooldown.secondsLeft})',
          onTap: (isLoading || !resendCooldown.canResend)
              ? () {}
              : registerCubit.resendCode,
        );

        return AuthScaffold(header: header, body: body, footer: footer);
      },
    );
  }
}
