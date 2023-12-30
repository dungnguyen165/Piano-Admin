import 'package:flutter/material.dart';
import '../../authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginForm(),
        ),
    );
  }
}
