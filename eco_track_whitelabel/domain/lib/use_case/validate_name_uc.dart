import 'dart:async';

import 'package:domain/exceptions.dart';
import 'package:domain/use_case/use_case.dart';

class ValidateNameUC extends UseCase<ValidateNameUCParams, void> {
  ValidateNameUC({
    required super.logger,
  });

  @override
  Future<void> getRawFuture(ValidateNameUCParams params) {
    final completer = Completer<void>();
    final name = params.name;

    if (name.isEmpty) {
      completer.completeError(EmptyFormFieldException());
    } else if (name.length < 3 || name.length > 30) {
      completer.completeError(InvalidFormFieldException());
    } else {
      completer.complete();
    }
    return completer.future;
  }
}

class ValidateNameUCParams {
  const ValidateNameUCParams(
      this.name,
      );

  final String name;
}
