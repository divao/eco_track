import 'package:domain/model/feed_post.dart';

abstract class FeedDataRepository {
  Future<List<FeedPost>> getFeedPosts();
}