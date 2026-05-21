import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:void_chat/features/auth/login/presentation/cubit/login_state.dart';
import 'package:void_chat/features/auth/login/presentation/widgets/sections/verify_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_footer_link.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/loading_button.dart';

@RoutePage()
class EmailConfirmScreen extends HookWidget {
  final String identifier;

  const EmailConfirmScreen({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final code = useState('');

    return BlocBuilder<LoginCubit, LoginState>(
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
            VerifyFormSection(onCodeCompleted: (pin) => code.value = pin),
            const SizedBox(height: 30),

            // Verify button
            LoadingButton(
              state: isLoading,
              button: FilledButton(
                onPressed: code.value.length == 4
                    ? () async => await context.read<LoginCubit>().verifyCode(
                        identifier,
                        code.value,
                      )
                    : null,
                child: Text(l10n.verifyEmailSubmit),
              ),
            ),
          ],
        );

        // Footer (resend code)
        final footer = AuthFooterLink(
          text: l10n.verifyEmailDidNotReceive,
          linkText: l10n.verifyEmailResendCode,
          onTap: () {},
        );

        return AuthScaffold(header: header, body: body, footer: footer);
      },
    );
  }
}
