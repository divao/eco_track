import 'dart:io';

import 'package:domain/data_repository/feed_data_repository.dart';
import 'package:domain/model/geolocation.dart';
import 'package:domain/use_case/use_case.dart';

class PostFeedPostUC extends UseCase<PostFeedPostUCParams, void> {
  PostFeedPostUC({
    required super.logger,
    required this.feedDataRepository,
  });

  final FeedDataRepository feedDataRepository;

  @override
  Future<void> getRawFuture(PostFeedPostUCParams params,) =>
      feedDataRepository.postFeedPost(
        file: params.file,
        description: params.description,
        geolocation: params.geolocation,
      );
}

class PostFeedPostUCParams {
  PostFeedPostUCParams({
    required this.file,
    required this.description,
    required this.geolocation,
  });

  final File file;
  final String description;
  final Geolocation geolocation;
}
