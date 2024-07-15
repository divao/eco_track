import 'package:domain/exceptions.dart';
import 'package:domain/use_case/validate_email_uc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data.dart';

void main() {
  late ValidateEmailUC useCase;

  setUp(() {
    useCase = ValidateEmailUC(logger: mockLogger);
  });

  test('should throw EmptyFormFieldException if email is empty', () async {
    expect(
          () => useCase.getFuture(
        const ValidateEmailUCParams(''),
      ),
      throwsA(
        isA<EmptyFormFieldException>(),
      ),
    );
  });

  test('should throw InvalidFormFieldException if email does not have @',
          () async {
        expect(
              () => useCase.getFuture(
            const ValidateEmailUCParams('abc123.com'),
          ),
          throwsA(
            isA<InvalidFormFieldException>(),
          ),
        );
      });

  test('should throw InvalidFormFieldException if email does not have .',
          () async {
        expect(
              () => useCase.getFuture(
            const ValidateEmailUCParams('abc123@com'),
          ),
          throwsA(
            isA<InvalidFormFieldException>(),
          ),
        );
      });

  test('should throw InvalidFormFieldException if email does not have domain',
          () async {
        expect(
              () => useCase.getFuture(
            const ValidateEmailUCParams('abc123@.com'),
          ),
          throwsA(
            isA<InvalidFormFieldException>(),
          ),
        );
      });

  test('should throw InvalidFormFieldException if email does not have TLD',
          () async {
        expect(
              () => useCase.getFuture(
            const ValidateEmailUCParams('abc123@domain'),
          ),
          throwsA(
            isA<InvalidFormFieldException>(),
          ),
        );
      });

  test('should complete without errors if email is valid', () async {
    await useCase.getFuture(
      const ValidateEmailUCParams(mockEmail),
    );
  });
}
