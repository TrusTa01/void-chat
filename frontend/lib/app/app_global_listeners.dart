import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/core/di/locator.dart';
import 'package:void_chat/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:void_chat/router/app_router.dart';

class AppGlobalListeners extends StatelessWidget {
  final Widget child;

  const AppGlobalListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthStatus>(
          listener: (context, state) {
            if (state == AuthStatus.unauthenticated) {
              getIt<AppRouter>().replaceAll([const LoginRoute()]);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
