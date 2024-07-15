import 'package:domain/model/feed_post.dart';
import 'package:domain/use_case/get_feed_posts_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import '../test_helper.mocks.dart';

void main() {
  late MockFeedDataRepository repository;
  late GetFeedPostsUC useCase;

  setUp(() {
    repository = MockFeedDataRepository();
    useCase = GetFeedPostsUC(
      repository: repository,
      logger: mockLogger,
    );
  });

  group('GetFeedPostsUC', () {
    test('should call repository.getFeedPosts one time', () async {
      when(
        repository.getFeedPosts(),
      ).thenAnswer((_) async => mockFeedPostList);

      final feedPostList = await useCase.getFuture(NoParams());

      expect(feedPostList, isA<List<FeedPost>>());
      expect(feedPostList[0].name, mockFeedPostList[0].name);
      verify(repository.getFeedPosts()).called(1);
    });
  });
}
