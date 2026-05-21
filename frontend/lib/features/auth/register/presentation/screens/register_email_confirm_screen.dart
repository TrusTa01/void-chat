import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:void_chat/features/auth/login/presentation/screens/email_confirm_screen.dart';

@RoutePage()
class RegisterEmailConfirmScreen extends StatelessWidget {
  final String identifier;

  const RegisterEmailConfirmScreen({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) =>
      EmailConfirmScreen(identifier: identifier);
}
