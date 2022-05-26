import 'package:formz/formz.dart';

enum ImageUrlValidationError {
  empty,
  short,
}

class ImageUrl extends FormzInput<String, ImageUrlValidationError> {
  const ImageUrl.pure() : super.pure('');
  const ImageUrl.dirty([String value = '']) : super.dirty(value);

  @override
  ImageUrlValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ImageUrlValidationError.empty;
  }
}
