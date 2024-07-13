import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/exceptions.dart';
import 'package:eco_track_whitelabel/common/utils.dart';
import 'package:eco_track_whitelabel/data/remote/model/feed_post_rm.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedRDS {
  FeedRDS({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  static const _postsCollection = 'posts';

  Future<List<FeedPostRM>> getFeedPosts() => _firebaseFirestore
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
              await getResourceUrlFromStorage(_firebaseStorage, imageUrl);
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
}
