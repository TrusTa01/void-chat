import 'package:flutter/material.dart';
import 'package:void_chat/features/auth/shared/presentation/widgets/ui_kits/switch_link.dart';

class AuthFooterLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;
  final double bottomPadding;

  const AuthFooterLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
    this.bottomPadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SwitchLink(text: text, linkText: linkText, onTap: onTap),
    );
  }
}
