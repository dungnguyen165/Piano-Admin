import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? 'Authentication Failure'),
            ));
        }
        if (state.status.isSuccess) {
          context.read<LoginCubit>().resetStatus();
          context.go('/login/otp');
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.piano_outlined, size: 120),
              const SizedBox(height: 16),
              _PhoneNumberInput(),
              const SizedBox(height: 8),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.phone != current.phone,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (phoneNumber) =>
                context.read<LoginCubit>().phoneChanged(phoneNumber),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              helperText: 'Enter your phone number',
              errorText:
                  state.phone.displayError != null ? 'invalid password' : null,
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator.adaptive()
          : ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color(0xFFFFD600),
              ),
              onPressed: state.isValid
                  ? () => context.read<LoginCubit>().login()
                  : null,
              child: Text(AppLocalizations.of(context)!.login),
            );
    });
  }
}
