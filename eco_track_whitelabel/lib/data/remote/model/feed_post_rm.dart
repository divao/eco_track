import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPostRM {
  const FeedPostRM({
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
  final GeoPoint geolocation;
}
