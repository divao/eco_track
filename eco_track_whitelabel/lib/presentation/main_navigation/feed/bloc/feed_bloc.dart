import 'package:bloc/bloc.dart';
import 'package:domain/use_case/get_feed_posts_uc.dart';
import 'package:domain/use_case/get_location_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/data/mappers/domain_to_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/get_geolocation_status.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final feedBlocProvider = Provider.autoDispose<FeedBloc>((ref) {
  final getFeedPostsUC = ref.watch(getFeedPostsUCProvider);
  final getLocationUC = ref.watch(getLocationUCProvider);
  return FeedBloc(
    getFeedPostsUC: getFeedPostsUC,
    getLocationUC: getLocationUC,
  );
});

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({
    required GetFeedPostsUC getFeedPostsUC,
    required GetLocationUC getLocationUC,
  })
      : _getFeedPostsUC = getFeedPostsUC,
        _getLocationUC = getLocationUC,
        super(Loading()) {
    on<GetFeed>(_fetchFeedPosts);
    on<TryAgain>(_fetchFeedPosts);
    on<GetGeolocation>(_getGeolocation);
  }

  final GetFeedPostsUC _getFeedPostsUC;
  final GetLocationUC _getLocationUC;

  void _fetchFeedPosts(FeedEvent event, Emitter emit) async {
    emit(Loading());
    try {
      final postList = await _getFeedPostsUC.getFuture(NoParams());
      emit(Success(
        feedPostList: postList.map((post) => post.toVM()).toList(),
        getGeolocationStatus: GetGeolocationStatus.idle,
      ));
    } catch (e) {
      emit(Error(mapToGenericViewErrorType(e)));
    }
  }

  void _getGeolocation(FeedEvent event, Emitter emit) async {
    final permission = await Permission.location.status;
    if (state is Success) {
      if (permission == PermissionStatus.granted) {
        final previousSuccessState = state as Success;
        emit(Loading());
        try {
          final geolocation = await _getLocationUC.getFuture(NoParams());
          emit(previousSuccessState.copyWith(
            getGeolocationStatus: GetGeolocationStatus.success,
            geolocation: geolocation,
          ));
        } catch (e) {
          emit(previousSuccessState.copyWith(
            getGeolocationStatus: GetGeolocationStatus.error,
          ));
        }
      } else {
        emit((state as Success).copyWith(
          getGeolocationStatus: GetGeolocationStatus.error,
        ));
      }
    }
  }
}
