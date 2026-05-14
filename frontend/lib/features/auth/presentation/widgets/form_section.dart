// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class FormSection extends HookWidget {
//   const FormSection({super.key});

//   void _fieldFocusChange(
//     BuildContext context,
//     FocusNode currentFocus,
//     FocusNode nextFocus,
//   ) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formKey = useMemoized(() => GlobalKey<FormState>());

//     return Form(
//       key: formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [],
//       ),
//     );
//   }
// }
