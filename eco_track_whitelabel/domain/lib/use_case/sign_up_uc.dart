import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';

class SignUpUC extends UseCase<SignUpUCParams, void> {
  SignUpUC({
    required AuthDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final AuthDataRepository _repository;

  @override
  Future<void> getRawFuture(SignUpUCParams params) => _repository.signUp(
    name: params.name,
    email: params.email,
    password: params.password,
  );
}

class SignUpUCParams {
  const SignUpUCParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
