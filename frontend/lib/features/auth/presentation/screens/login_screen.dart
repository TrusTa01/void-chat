import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:void_chat/features/auth/presentation/screens/register_screen.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register screen')),
      body: Center(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _controller,
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                debugPrint('Текст из поля: ${_controller.text}');
              },
              child: const Text('Войти'),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
