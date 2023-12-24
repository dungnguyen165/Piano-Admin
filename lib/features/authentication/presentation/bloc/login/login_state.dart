import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:piano_admin/features/authentication/domain/entity/email_entity.dart';
import 'package:piano_admin/features/authentication/domain/entity/password_entity.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const EmailEntity.pure(),
    this.password = const PasswordEntity.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final EmailEntity email;
  final PasswordEntity password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  LoginState copyWith({
    EmailEntity? email,
    PasswordEntity? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage];
}
