import 'package:domain/model/geolocation.dart';

class FeedPost {
  const FeedPost({
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
  final Geolocation geolocation;
}