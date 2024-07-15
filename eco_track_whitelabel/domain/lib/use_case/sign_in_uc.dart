import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';

class SignInUC extends UseCase<SignInUCParams, void> {
  SignInUC({
    required super.logger,
    required this.authRepository,
  });

  final AuthDataRepository authRepository;

  @override
  Future<void> getRawFuture(SignInUCParams params) => authRepository.signIn(
    email: params.email,
    password: params.password,
  );
}

class SignInUCParams {
  SignInUCParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
