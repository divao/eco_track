import 'dart:io';

import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/use_case/use_case.dart';

class EditProfileUC extends UseCase<EditProfileUCParams, void> {
  EditProfileUC({
    required AuthDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final AuthDataRepository _repository;

  @override
  Future<void> getRawFuture(EditProfileUCParams params) => _repository.editProfile(
    name: params.name,
    profileImage: params.profileImage,
  );
}

class EditProfileUCParams {
  const EditProfileUCParams({
    this.name,
    this.profileImage,
  });

  final String? name;
  final File? profileImage;
}
