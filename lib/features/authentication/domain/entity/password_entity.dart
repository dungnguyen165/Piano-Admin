import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordEntity extends FormzInput<String, PasswordValidationError> {
  const PasswordEntity.pure() : super.pure('');

  const PasswordEntity.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return null;
    // return _passwordRegExp.hasMatch(value ?? '')
    //     ? null
    //     : PasswordValidationError.invalid;
  }
}
