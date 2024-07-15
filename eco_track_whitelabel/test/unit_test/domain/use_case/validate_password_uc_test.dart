import 'package:domain/exceptions.dart';
import 'package:domain/use_case/validate_password_uc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data.dart';

void main() {
  late ValidatePasswordUC useCase;

  setUp(() {
    useCase = ValidatePasswordUC(logger: mockLogger);
  });

  test('should throw EmptyFormFieldException if password is empty', () async {
    expect(
          () => useCase.getFuture(
        const ValidatePasswordUCParams(''),
      ),
      throwsA(
        isA<EmptyFormFieldException>(),
      ),
    );
  });

  test(
      'should throw InvalidFormFieldException if password does '
          'not have more than 6 characters', () async {
    expect(
          () => useCase.getFuture(
        const ValidatePasswordUCParams('Abc12'),
      ),
      throwsA(
        isA<InvalidFormFieldException>(),
      ),
    );
  });

  test('should complete without error if password is valid', () async {
    await useCase.getFuture(
      const ValidatePasswordUCParams(mockPassword),
    );
  });
}
