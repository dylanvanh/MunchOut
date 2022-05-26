import 'package:formz/formz.dart';

enum DescriptionValidationError {
  empty,
  short,
}

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : DescriptionValidationError.empty;
  }
}
