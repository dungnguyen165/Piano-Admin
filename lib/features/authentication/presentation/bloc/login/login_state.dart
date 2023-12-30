import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:piano_admin/features/authentication/domain/entity/otp_entity.dart';
import 'package:piano_admin/features/authentication/domain/entity/phone_entity.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.phone = const PhoneEntity.pure(),
    this.otp = const OtpEntity.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final PhoneEntity phone;
  final OtpEntity otp;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  LoginState copyWith({
    PhoneEntity? phone,
    OtpEntity? otp,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [phone, otp, status, isValid, errorMessage];
}
