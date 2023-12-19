import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Page<void> page() => const MaterialPage(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text(
          'Sign Up Page'
        ),
      ),
    );
  }
}
