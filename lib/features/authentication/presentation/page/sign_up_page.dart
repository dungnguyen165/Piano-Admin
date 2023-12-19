import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Page<void> page() => const MaterialPage(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp),
      ),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.signUp
        ),
      ),
    );
  }
}
