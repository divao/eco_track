import 'package:domain/exceptions.dart';

enum InputStatus {
  empty,
  invalid,
  valid,
  wrong,
  undefined,
}

const _errorMap = {
  InvalidFormFieldException: InputStatus.invalid,
  EmptyFormFieldException: InputStatus.empty,
};

InputStatus mapToInputStatus(dynamic err) =>
    _errorMap[err.runtimeType] ?? InputStatus.undefined;
