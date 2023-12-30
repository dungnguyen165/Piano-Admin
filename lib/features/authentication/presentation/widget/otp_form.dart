import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:piano_admin/core/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../authentication.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) {
        logger.d(
            'listenWhen previous ${previous.status} current ${current.status} ${previous.status != current.status}');
        return previous.status != current.status;
      },
      listener: (context, state) {
        logger.d('listen ${state.status}');
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? 'Authentication Failure'),
            ));
        }
        if (state.status.isSuccess) {
          context.go('/');
        }
      },
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.code,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 16),
                state.status.isInProgress
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _OtpInput(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OtpInput extends StatefulWidget {
  @override
  State<_OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<_OtpInput> {
  final length = 6;

  final borderColor = const Color.fromRGBO(114, 178, 238, 1);

  final errorColor = const Color.fromRGBO(255, 234, 238, 1);

  final fillColor = const Color.fromRGBO(222, 231, 240, .57);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: GoogleFonts.poppins(
      fontSize: 22,
      color: const Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(222, 231, 240, .57),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.otp != current.otp,
        builder: (context, state) {
          return SizedBox(
            height: 68,
            child: Pinput(
              length: length,
              controller: controller,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              onChanged: (pin) {
                context.read<LoginCubit>().otpChanged(pin);
              },
              onCompleted: (pin) {
                logger.d('onCompleted, otp $pin');
                context.read<LoginCubit>().verifyOtp();
              },
              focusedPinTheme: defaultPinTheme.copyWith(
                height: 68,
                width: 64,
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: borderColor),
                ),
              ),
              errorText: state.errorMessage,
              errorPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                  color: errorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        });
  }
}
