import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/exceptions.dart';
import 'package:eco_track_whitelabel/common/utils.dart';
import 'package:eco_track_whitelabel/data/remote/model/user_profile_rm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRDS {
  UserRDS({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required FirebaseStorage firebaseStorage,
  })  : _firestore = firebaseFirestore,
        _auth = firebaseAuth,
        _storage = firebaseStorage;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  static const _profilesCollection = 'profiles';

  Future<void> setUserAdditionalData({
    required String name,
    required File profileImage,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }
    final userUid = user.uid;
    final imageUrl = 'profileImages/$userUid';
    final imageRef = _storage.ref().child(imageUrl);
    try {
      await imageRef.putFile(profileImage);
      await user.updateDisplayName(name);
      await _firestore.collection(_profilesCollection).doc(user.uid).set(
        {
          'name': name,
          'imageUrl': imageUrl,
        },
      );
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Future<UserProfileRM> getUserProfile() {
    final user = _auth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }
    try {
      return _firestore
          .collection(_profilesCollection)
          .doc(user.uid)
          .get()
          .then((response) async {
        final data = response.data()!;
        final {
          'name': String name,
          'imageUrl': String imageUrl,
        } = data;
        final profileImage =
            await getResourceUrlFromStorage(_storage, imageUrl);
        return UserProfileRM(
          name: name,
          email: user.email!,
          imageUrl: profileImage,
        );
      });
    } catch (e) {
      throw ResponseParseException();
    }
  }

  Future<void> editProfile({
    String? name,
    File? profileImage,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }
    try {
      if (profileImage != null) {
        final userUid = user.uid;
        final imageUrl = 'profileImages/$userUid';
        final imageRef = _storage.ref().child(imageUrl);

        await imageRef.putFile(profileImage);
      }

      if (name != null) {
        await user.updateDisplayName(name);
        await _firestore.collection(_profilesCollection).doc(user.uid).update(
          {
            'name': name,
          },
        );
      }
    } catch (e) {
      throw ResponseParseException();
    }
  }
}
