import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty, short }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PhoneNumberValidationError.empty;
  }
}
