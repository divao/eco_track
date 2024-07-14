import 'package:domain/model/feed_post.dart';
import 'package:domain/model/geolocation.dart';
import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/data/remote/model/geolocation_vm.dart';
import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';
import 'package:eco_track_whitelabel/data/view/model/profile_vm.dart';

extension FeedPostDMMappers on FeedPost {
  FeedPostVM toVM() => FeedPostVM(
    name: name,
    profileImageUrl: profileImageUrl,
    postImageUrl: postImageUrl,
    description: description,
    geolocation: geolocation.toVM(),
  );
}

extension GeolocationDMMappers on Geolocation {
  GeolocationVM toVM() => GeolocationVM(
    latitude: latitude,
    longitude: longitude,
  );
}

extension ProfileDMMappers on UserProfile {
  ProfileVM toVM() => ProfileVM(
    name: name,
    email: email,
    imageUrl: imageUrl,
  );
}