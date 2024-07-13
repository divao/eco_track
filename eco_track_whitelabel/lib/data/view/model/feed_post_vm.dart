import 'package:eco_track_whitelabel/data/remote/model/geolocation_vm.dart';

class FeedPostVM {
  FeedPostVM({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.geolocation,
  });

  final String name;
  final String imageUrl;
  final String description;
  final GeolocationVM geolocation;
}
