import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthLayoutScreen extends StatelessWidget {
  const AuthLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return AutoRouter(
      builder: (context, content) {
        final canPop = context.router.canPop();

        return Scaffold(
          appBar: AppBar(
            leading: canPop
                ? BackButton(onPressed: () => context.router.maybePop())
                : null,
            title: isLight
                ? Image.asset(
                    'assets/logo/logo_light.png',
                    height: 100,
                    width: 125,
                  )
                : Image.asset(
                    'assets/logo/logo_dark.png',
                    height: 100,
                    width: 125,
                  ),
            centerTitle: true,
          ),
          body: SafeArea(child: content),
        );
      },
    );
  }
}
