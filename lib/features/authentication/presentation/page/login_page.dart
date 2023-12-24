import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_state.dart';
import 'package:piano_admin/features/authentication/presentation/widget/login_form.dart';
import '../../../../injection_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => sl(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.login),
        ),
        body: const Padding(padding: EdgeInsets.all(8.0), child: LoginForm()),
      ),
    );
  }
}
