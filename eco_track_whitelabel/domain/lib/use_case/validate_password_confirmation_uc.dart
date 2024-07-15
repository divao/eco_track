import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';

class ValidatePasswordConfirmationUC
    extends UseCase<ValidatePasswordConfirmationUCParams, void> {
  ValidatePasswordConfirmationUC({
    required super.logger,
  });

  @override
  Future<void> getRawFuture(ValidatePasswordConfirmationUCParams params) {
    final password = params.password;
    final passwordConfirmation = params.passwordConfirmation;
    final completer = Completer<void>();

    if (passwordConfirmation.isEmpty) {
      completer.completeError(EmptyFormFieldException());
      return completer.future;
    }

    if (passwordConfirmation != password) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }

    return completer.future;
  }
}

class ValidatePasswordConfirmationUCParams {
  ValidatePasswordConfirmationUCParams({
    required this.password,
    required this.passwordConfirmation,
  });

  final String password;
  final String passwordConfirmation;
}
