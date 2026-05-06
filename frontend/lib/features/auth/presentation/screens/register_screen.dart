import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controller = TextEditingController();

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
                decoration: const InputDecoration(labelText: 'Email'),
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
