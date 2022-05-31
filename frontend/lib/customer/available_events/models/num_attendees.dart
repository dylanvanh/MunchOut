import 'package:formz/formz.dart';

enum NumAttendeesValidationError {
  empty,
  short,
}

class NumAttendees extends FormzInput<String, NumAttendeesValidationError> {
  const NumAttendees.pure() : super.pure('');
  const NumAttendees.dirty([String value = '']) : super.dirty(value);

  @override
  NumAttendeesValidationError? validator(String? value) {
    // return value?.isNotEmpty == true ? null : NumAttendeesValidationError.empty;
    try {
      int.parse(value!);
      return null;
    } on Exception {
      print('Invalid number');
    }
  }
}
