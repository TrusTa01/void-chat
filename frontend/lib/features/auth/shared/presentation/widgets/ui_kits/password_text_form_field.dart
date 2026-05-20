import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;

  /// A focus of a next field
  final FocusNode? nextFocus;

  /// A function to switch focus
  final void Function(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  )?
  focusNext;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final VoidCallback? onSuffixIconTap;
  final ValueNotifier<bool> hidePass;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;

  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.focus,
    this.nextFocus,
    this.focusNext,
    required this.obscureText,
    required this.labelText,
    required this.hintText,
    this.onSuffixIconTap,
    required this.hidePass,
    required this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focus,
      obscureText: obscureText,
      textInputAction: nextFocus == null
          ? TextInputAction.done
          : TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
      onFieldSubmitted: nextFocus != null
          ? (_) {
              if (focusNext != null) {
                focusNext!(context, focus, nextFocus!);
              }
            }
          : null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: onSuffixIconTap != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: onSuffixIconTap,
                  icon: Icon(
                    hidePass.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              )
            : null,
      ),
      maxLines: 1,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
