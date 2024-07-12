import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/model/user_profile.dart';
import 'package:domain/use_case/use_case.dart';

class GetUserProfileUC extends UseCase<NoParams, UserProfile> {
  GetUserProfileUC({
    required AuthDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final AuthDataRepository _repository;

  @override
  Future<UserProfile> getRawFuture(NoParams params) =>
      _repository.getUserProfile();
}