import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final List<Widget> children;
  final GlobalKey<FormState>? formKey;

  const FormSection({super.key, required this.children, this.formKey});

  static void focusNext(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
