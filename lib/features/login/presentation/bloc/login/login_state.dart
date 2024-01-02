import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:piano_admin/core/core.dart';
import '../../../login.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.phone = const PhoneEntity.pure(),
    this.otp = const OtpEntity.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.error,
  });

  final PhoneEntity phone;
  final OtpEntity otp;
  final FormzSubmissionStatus status;
  final bool isValid;
  final LoginFailure? error;

  LoginState copyWith({
    PhoneEntity? phone,
    OtpEntity? otp,
    FormzSubmissionStatus? status,
    bool? isValid,
    LoginFailure? error,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [phone, otp, status, isValid, error];
}
