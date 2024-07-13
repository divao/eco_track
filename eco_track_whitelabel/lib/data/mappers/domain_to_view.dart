import 'package:domain/model/feed_post.dart';
import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/data/remote/model/geolocation_vm.dart';
import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';

extension FeedPostDMMappers on FeedPost {
  FeedPostVM toVM() => FeedPostVM(
    name: name,
    imageUrl: imageUrl,
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