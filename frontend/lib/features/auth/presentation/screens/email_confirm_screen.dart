import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmailConfirmScreen extends StatelessWidget {
  const EmailConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Login via username has not yet been completed. Please log in using password.\n\nВход через логин еще не готов, просьба войти через пароль',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
