import 'package:domain/model/geolocation.dart';

class FeedPost {
  const FeedPost({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.geolocation,
  });

  final String name;
  final String imageUrl;
  final String description;
  final Geolocation geolocation;
}