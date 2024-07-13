import 'package:bloc/bloc.dart';
import 'package:domain/use_case/get_feed_posts_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/data/mappers/domain_to_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedBlocProvider = Provider.autoDispose<FeedBloc>((ref) {
  final getFeedPostsUC = ref.watch(getFeedPostsUCProvider);
  return FeedBloc(
    getFeedPostsUC: getFeedPostsUC,
  );
});

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({
    required GetFeedPostsUC getFeedPostsUC,
  })  : _getFeedPostsUC = getFeedPostsUC,
        super(Loading()) {
    on<GetFeed>(_fetchFeedPosts);
    on<TryAgain>(_fetchFeedPosts);
  }

  final GetFeedPostsUC _getFeedPostsUC;

  void _fetchFeedPosts(FeedEvent event, Emitter emit) async {
    emit(Loading());
    try {
      final postList = await _getFeedPostsUC.getFuture(NoParams());
      emit(Success(feedPostList: postList.map((post) => post.toVM()).toList()));
    } catch (e) {
      emit(Error(mapToGenericViewErrorType(e)));
    }
  }
}
