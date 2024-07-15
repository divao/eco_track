import 'package:domain/exceptions.dart';

enum GenericErrorViewType { unexpected, noConnection, timeout }

class GenericErrorView {
  final GenericErrorViewType type = GenericErrorViewType.unexpected;
}

const _errorMap = {
  NoConnectionException: GenericErrorViewType.noConnection,
  ConnectionTimedOutException: GenericErrorViewType.timeout,
  UnexpectedException: GenericErrorViewType.unexpected,
};

GenericErrorViewType mapToGenericViewErrorType(
    dynamic object, {
      StackTrace? stackTrace,
    }) {
  final genericError = _errorMap[object.runtimeType];

  return genericError ?? GenericErrorViewType.unexpected;
}