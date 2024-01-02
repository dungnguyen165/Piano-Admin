import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateUserNamePage extends StatelessWidget {
  const UpdateUserNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.userName)),
      body: Center(child: Text(l10n.userName)),
    );
  }
}
