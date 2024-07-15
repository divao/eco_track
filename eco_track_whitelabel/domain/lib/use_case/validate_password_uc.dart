import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';

class ValidatePasswordUC extends UseCase<ValidatePasswordUCParams, void> {
  ValidatePasswordUC({
    required super.logger,
  });

  @override
  Future<void> getRawFuture(ValidatePasswordUCParams params) {
    final completer = Completer<void>();
    final password = params.password;

    if (password.isEmpty) {
      completer.completeError(EmptyFormFieldException());
    } else if (password.length < 6 || password.length > 100) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }
    return completer.future;
  }
}

class ValidatePasswordUCParams {
  const ValidatePasswordUCParams(
      this.password,
      );

  final String password;
}
