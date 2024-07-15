import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';

class DeleteUserUC extends UseCase<DeleteUserUCParams, void> {
  DeleteUserUC({
    required AuthDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final AuthDataRepository _repository;

  @override
  Future<void> getRawFuture(DeleteUserUCParams params) =>
      _repository.deleteUser(
        deleteData: params.deleteData,
        password: params.password,
      );
}

class DeleteUserUCParams {
  const DeleteUserUCParams({
    required this.deleteData,
    required this.password,
  });

  final bool deleteData;
  final String password;
}
