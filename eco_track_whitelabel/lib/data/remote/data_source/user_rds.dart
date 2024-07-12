import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/exceptions.dart';
import 'package:eco_track_whitelabel/data/remote/model/user_profile_rm.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRDS {
  UserRDS({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  static const _profilesCollection = 'profiles';

  Future<void> setUserAdditionalData({
    required String name,
  }) async {

    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }
    try {
      await user.updateDisplayName(name);
      await _firebaseFirestore
          .collection(_profilesCollection)
          .doc(user.uid)
          .set(
        {
          'name': name,
        },
      );
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Future<UserProfileRM> getUserProfile() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }

    try {
      return _firebaseFirestore
          .collection(_profilesCollection)
          .doc(user.uid)
          .get()
          .then((response) async {
        final data = response.data()!;
        final {
        'name': String name,
        } = data;
        return UserProfileRM(
          name: name,
        );
      });
    } catch (e) {
      throw ResponseParseException();
    }
  }
}
