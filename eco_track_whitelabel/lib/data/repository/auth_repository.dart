import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/data/mappers/remote_to_domain.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/auth_rds.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/user_rds.dart';

class AuthRepository extends AuthDataRepository {
  AuthRepository({
    required AuthRDS authRDS,
    required UserRDS userRDS,
  })  : _authRDS = authRDS,
        _userRDS = userRDS;

  final AuthRDS _authRDS;
  final UserRDS _userRDS;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authRDS.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _authRDS.signUp(
      email: email,
      password: password,
    );
    try {
      await _userRDS.setUserAdditionalData(
        name: name,

      );
    } catch (e) {
      await _authRDS.deleteUser(
        deleteData: false,
        password: password,
      );
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _authRDS.signOut();
  }

  @override
  Future<UserProfile> getUserProfile() async =>
      _userRDS.getUserProfile().then((userProfileRM) => userProfileRM.toDM());

  @override
  Future<void> deleteUser({
    required bool deleteData,
    required String password,
  }) async =>
      _authRDS.deleteUser(
        deleteData: deleteData,
        password: password,
      );
}
