import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:void_chat/features/auth/presentation/screens/email_confirm_screen.dart';

@RoutePage()
class RegisterEmailConfirmScreen extends StatelessWidget {
  final String userEmail;
  final VoidCallback onVerifyPressed;

  const RegisterEmailConfirmScreen({
    super.key,
    required this.userEmail,
    required this.onVerifyPressed,
  });

  @override
  Widget build(BuildContext context) => EmailConfirmScreen(
    userEmail: userEmail,
    onVerifyPressed: onVerifyPressed,
  );
}
