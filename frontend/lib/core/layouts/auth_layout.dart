import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthLayoutScreen extends StatelessWidget {
  const AuthLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        final canPop = context.router.canPop();

        return Scaffold(
          appBar: AppBar(
            leading: canPop
                ? BackButton(onPressed: () => context.router.back())
                : null,
          ),
          body: Column(
            children: [
              const Text('Добро пожаловать в Void Chat!'),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }
}
