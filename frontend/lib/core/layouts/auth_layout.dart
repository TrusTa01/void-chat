import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthLayoutScreen extends StatelessWidget {
  const AuthLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/logo/logo.png', height: 100, width: 125),
            centerTitle: true,
          ),
          body: SafeArea(child: content),
        );
      },
    );
  }
}
