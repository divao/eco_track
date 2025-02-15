import 'dart:io';

import 'package:domain/model/user_profile.dart';

abstract class AuthDataRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required File profileImage,
  });

  Future<void> signOut();

  Future<UserProfile> getUserProfile();

  Future<void> deleteUser({
    required bool deleteData,
    required String password,
  });

  Future<void> editProfile({
    String? name,
    File? profileImage,
  });
}