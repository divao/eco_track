import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/feed_post.dart';
import 'package:domain/model/geolocation.dart';
import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/data/remote/model/feed_post_rm.dart';
import 'package:eco_track_whitelabel/data/remote/model/user_profile_rm.dart';

extension UserProfileRMMappers on UserProfileRM {
  UserProfile toDM() => UserProfile(
    name: name,
  );
}

extension FeedPostRMMappers on FeedPostRM {
  FeedPost toDM() => FeedPost(
    name: name,
    imageUrl: imageUrl,
    description: description,
    geolocation: geolocation.toDM(),
  );
}

extension GeoPointRMMappers on GeoPoint {
  Geolocation toDM() => Geolocation(
    latitude: latitude,
    longitude: longitude,
  );
}
