import 'package:domain/data_repository/feed_data_repository.dart';
import 'package:domain/model/feed_post.dart';
import 'package:domain/use_case/use_case.dart';

class GetFeedPostsUC extends UseCase<NoParams, List<FeedPost>> {
  GetFeedPostsUC({
    required FeedDataRepository repository,
    required super.logger,
  }) : _repository = repository;

  final FeedDataRepository _repository;

  @override
  Future<List<FeedPost>> getRawFuture(NoParams params) =>
      _repository.getFeedPosts();
}