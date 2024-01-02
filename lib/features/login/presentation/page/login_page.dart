import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.translate_outlined),
            onPressed: () {
              context.go('/login/language');
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginForm(),
      ),
    );
  }
}
