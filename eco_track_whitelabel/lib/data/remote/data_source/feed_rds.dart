import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/common/utils.dart';
import 'package:eco_track_whitelabel/data/remote/model/feed_post_rm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedRDS {
  FeedRDS({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
    required FirebaseAuth firebaseAuth,
  })  : _firestore = firebaseFirestore,
        _storage = firebaseStorage,
        _auth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  static const _postsCollection = 'posts';

  Future<List<FeedPostRM>> getFeedPosts() => _firestore
          .collection(_postsCollection)
          .get()
          .then((snapshot) async {
        final postList = <FeedPostRM>[];
        for (final doc in snapshot.docs) {
          final data = doc.data();
          final {
            'name': String name,
            'imageUrl': String imageUrl,
            'description': String description,
            'geolocation': GeoPoint geolocation,
          } = data;
          final image =
              await getResourceUrlFromStorage(_storage, imageUrl);
          final postRM = FeedPostRM(
            name: name,
            imageUrl: image,
            description: description,
            geolocation: geolocation,
          );
          postList.add(postRM);
        }
        return postList;
      }).catchError((e) {
        throw ResponseParseException();
      });

  Future<void> postFeedPost({
    required File file,
    required String description,
    required Geolocation geolocation,
  }) async {
    final userUid = _auth.currentUser!.uid;
    final imageUrl = 'postImages/$userUid/${DateTime.now()}';
    final imageRef = _storage.ref().child(imageUrl);
    try {
      await imageRef.putFile(file);
      final geoPoint = GeoPoint(geolocation.latitude, geolocation.longitude);
      await _firestore.collection(_postsCollection).add({
        // TODO: trocar isso aqui
        'name': 'Teste legal',
        'imageUrl': imageUrl,
        'description': description,
        'geolocation': geoPoint,
      });
    } catch (e) {
      throw UnexpectedException();
    }
  }
}
