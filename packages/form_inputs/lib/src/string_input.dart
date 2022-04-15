import 'package:formz/formz.dart';

/// Validation errors for the [StringInput] [FormzInput].
enum StringInputValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class StringInput extends FormzInput<String, StringInputValidationError> {
  /// {@macro email}
  const StringInput.pure() : super.pure('');

  /// {@macro email}
  const StringInput.dirty([String value = '']) : super.dirty(value);

  @override
  StringInputValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : StringInputValidationError.invalid;
  }
}
