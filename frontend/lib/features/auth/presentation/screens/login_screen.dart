import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:void_chat/core/extensions/l10n_ext.dart';
import 'package:void_chat/core/theme/app_colors.dart';
import 'package:void_chat/features/auth/presentation/widgets/login_form.dart';
import 'package:void_chat/router/app_router.dart';

@RoutePage()
class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final registerTap = useMemoized(() => TapGestureRecognizer(), []);
    registerTap.onTap = () => context.router.push(const RegisterRoute());
    useEffect(() => registerTap.dispose, [registerTap]);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 40),
                      child: Column(
                        children: [
                          // Main text
                          Text(
                            l10n.greeting,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Description under a main text
                          Text(
                            l10n.greetingDescription,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Forms
                    const Padding(
                      padding: EdgeInsets.all(22),
                      child: LoginFormSection(),
                    ),
                  ],
                ),

                // Register
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: '${l10n.dontHaveAcc}? ',
                      children: [
                        TextSpan(
                          text: l10n.singUp,
                          style: const TextStyle(color: AppColors.lightPrimary),
                          recognizer: registerTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
