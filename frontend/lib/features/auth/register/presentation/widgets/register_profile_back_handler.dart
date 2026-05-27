import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/l10n/l10n_ext.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:void_chat/features/auth/register/presentation/cubit/register_state.dart';
import 'package:void_chat/features/auth/register/presentation/extensions/register_failure_message.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/app_snack_bar.dart';
import 'package:void_chat/router/app_router.dart';

Future<bool> showRegisterResetDialog(BuildContext context) {
  final l10n = context.l10n;
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.registerResetDialogTitle),
      content: Text(l10n.registerResetDialogMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.registerResetDialogConfirm),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.registerResetDialogStay),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}

Future<void> handleRegisterProfileBack(BuildContext context) async {
  final confirmed = await showRegisterResetDialog(context);
  if (!confirmed || !context.mounted) return;

  await context.read<RegisterCubit>().cancelAndReset();
  if (!context.mounted) return;

  final state = context.read<RegisterCubit>().state;
  if (state is RegisterError) {
    context.showAppSnackBar(state.failure.messages(context.l10n));
    return;
  }

  await context.router.replaceAll([const RegisterRoute()]);
}

/// App bar back on profile setup (step 3): confirm, cancel pending, go to register.
class RegisterProfileBackButton extends StatelessWidget {
  const RegisterProfileBackButton({super.key});

  @override
  Widget build(BuildContext context) =>
      BackButton(onPressed: () => handleRegisterProfileBack(context));
}
