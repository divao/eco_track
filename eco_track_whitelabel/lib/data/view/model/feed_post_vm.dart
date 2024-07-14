import 'package:eco_track_whitelabel/data/remote/model/geolocation_vm.dart';

class FeedPostVM {
  FeedPostVM({
    required this.name,
    required this.profileImageUrl,
    required this.postImageUrl,
    required this.description,
    required this.geolocation,
  });

  final String name;
  final String profileImageUrl;
  final String postImageUrl;
  final String description;
  final GeolocationVM geolocation;
}
