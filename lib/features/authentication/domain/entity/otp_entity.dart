import 'package:formz/formz.dart';

enum OtpValidationError { invalid }

class OtpEntity extends FormzInput<String, OtpValidationError> {
  const OtpEntity.pure() : super.pure('');

  const OtpEntity.dirty([super.value = '']) : super.dirty();

  static final RegExp _otpRegExp = RegExp(
    r'^[0-9]{6}$',
  );

  @override
  OtpValidationError? validator(String? value) {
    return _otpRegExp.hasMatch(value ?? '') ? null : OtpValidationError.invalid;
  }
}
