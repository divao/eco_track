import 'package:domain/exceptions.dart';
import 'package:domain/logger.dart';

abstract class UseCase<P, R> {
  const UseCase({
    required this.logger,
  });

  final ErrorLogger logger;

  Future<R> getRawFuture(P params);

  Future<R> getFuture(P params) async {
    try {
      return await getRawFuture(params);
    } catch (error, stackTrace) {
      await logger('UseCase Error', error, stackTrace);

      if (error is EcoTrackException) {
        rethrow;
      } else {
        throw UnexpectedException();
      }
    }
  }
}

class NoParams {}