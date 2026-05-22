import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/extensions/theme_context_ext.dart';
import 'package:void_chat/core/layouts/auth_layout.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_state.dart';
import 'package:void_chat/features/auth/register/presentation/extensions/register_failure_message.dart';
import 'package:void_chat/features/auth/register/presentation/widgets/register_profile_back_handler.dart';
import 'package:void_chat/features/auth/register/presentation/widgets/sections/profile_form_section.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_body.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/components/auth_header.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await handleRegisterProfileBack(context);
      },
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listenWhen: (_, current) =>
            current is RegisterCompleted || current is RegisterError,

        listener: (context, state) {
          switch (state) {
            case RegisterCompleted():
              context.router.replaceAll([const AppLayoutRoute()]);
            case RegisterError(:final failure):
              context.showAppSnackBar(failure.messages(l10n));
            default:
              break;
          }
        },

        builder: (context, state) {
          final isLoading = state is RegisterLoading;
          final registerCubit = context.read<RegisterCubit>();

          final header = AuthHeader(
            mainText: l10n.profileSetupMainText,
            description: l10n.profileSetupSecondText,
            imageAssetPath: context.portalImagePath,
          );

          final body = AuthBody(
            children: [
              ProfileFormSection(
                isLoading: isLoading,
                onCompleteTap: (username, displayName) =>
                    registerCubit.completeProfile(
                      username: username,
                      displayName: displayName,
                    ),
              ),
            ],
          );

          return AuthScaffold(header: header, body: body);
        },
      ),
    );
  }
}
