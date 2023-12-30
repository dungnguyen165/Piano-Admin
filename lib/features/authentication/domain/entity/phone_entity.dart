import 'package:formz/formz.dart';

enum PhoneValidationError { invalid }

class PhoneEntity extends FormzInput<String, PhoneValidationError> {
  const PhoneEntity.pure() : super.pure('');

  const PhoneEntity.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(
    r'^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
  );

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}
