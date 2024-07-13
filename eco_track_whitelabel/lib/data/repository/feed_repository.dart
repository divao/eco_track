import 'package:domain/data_repository/feed_data_repository.dart';
import 'package:domain/model/feed_post.dart';
import 'package:eco_track_whitelabel/data/mappers/remote_to_domain.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/feed_rds.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/user_rds.dart';

class FeedRepository extends FeedDataRepository {
  FeedRepository({
    required FeedRDS feedRDS,
    required UserRDS userRDS,
  })  : _feedRDS = feedRDS,
        _userRDS = userRDS;

  final FeedRDS _feedRDS;
  final UserRDS _userRDS;

  @override
  Future<List<FeedPost>> getFeedPosts() async => _feedRDS.getFeedPosts().then(
        (feedPostListRM) => feedPostListRM.map((feedPostRM) => feedPostRM.toDM()).toList(),
      );
}
