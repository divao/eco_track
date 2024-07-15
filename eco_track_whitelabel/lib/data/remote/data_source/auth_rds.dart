import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRDS {
  AuthRDS({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-email' ||
          e.code == 'invalid-credential') {
        throw InvalidCredentialsException();
      } else {
        throw UnexpectedException();
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw UnexpectedException();
      }
    }
  }

  Future<void> deleteUser({
    required bool deleteData,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw UnexpectedException();
    }
    try {
      final authCredential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(authCredential);

      if (deleteData) {
        final userRef = _firestore.collection('profiles').doc(user.uid);
        final userDoc = await userRef.get();

        if (userDoc.exists) {
          await userDoc.reference.delete();
        }

        final userPostsRef = _firestore.collection('posts').where('userUid', isEqualTo: user.uid);
        final userPostsDoc = await userPostsRef.get();

        if (userPostsDoc.docs.isNotEmpty) {
          for (final post in userPostsDoc.docs) {
            await post.reference.delete();
          }
        }
      }

      await user.reauthenticateWithCredential(authCredential);
      await user.delete();
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> getUserUid() {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw UserNotLoggedException();
    } else {
      return Future.value(currentUser.uid);
    }
  }

}
