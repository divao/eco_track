import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';

class SignOutUC extends UseCase<NoParams, void> {
  SignOutUC({
    required AuthDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final AuthDataRepository _repository;

  @override
  Future<void> getRawFuture(NoParams params) => _repository.signOut();
}
