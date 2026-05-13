import 'package:flutter/material.dart';
import 'package:void_chat/core/theme/app_colors.dart';

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider(BuildContext context, {super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.lightPrimary),
          ),
        ),

        const Expanded(child: Divider()),
      ],
    );
  }
}
