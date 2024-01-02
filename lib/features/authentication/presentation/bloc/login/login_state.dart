import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../authentication.dart';

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
  final LogInWithPhoneNumberFailure? error;

  LoginState copyWith({
    PhoneEntity? phone,
    OtpEntity? otp,
    FormzSubmissionStatus? status,
    bool? isValid,
    LogInWithPhoneNumberFailure? error,
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
