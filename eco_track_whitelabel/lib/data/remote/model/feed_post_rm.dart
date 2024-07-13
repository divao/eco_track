import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPostRM {
  const FeedPostRM({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.geolocation,
  });

  final String name;
  final String imageUrl;
  final String description;
  final GeoPoint geolocation;
}
