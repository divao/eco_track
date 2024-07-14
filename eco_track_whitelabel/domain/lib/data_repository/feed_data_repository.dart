import 'dart:io';

import 'package:domain/model/feed_post.dart';
import 'package:domain/model/geolocation.dart';

abstract class FeedDataRepository {
  Future<List<FeedPost>> getFeedPosts();

  Future<void> postFeedPost({
    required File file,
    required String description,
    required Geolocation geolocation,
  });
}