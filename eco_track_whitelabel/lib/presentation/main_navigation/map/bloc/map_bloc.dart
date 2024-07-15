import 'package:bloc/bloc.dart';
import 'package:domain/use_case/get_feed_posts_uc.dart';
import 'package:domain/use_case/get_location_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/data/mappers/domain_to_view.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/map/bloc/map_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/map/bloc/map_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final mapBlocProvider = Provider.autoDispose<MapBloc>((ref) {
  final getFeedPostsUC = ref.watch(getFeedPostsUCProvider);
  final getLocationUC = ref.watch(getLocationUCProvider);
  return MapBloc(
    getFeedPostsUC: getFeedPostsUC,
    getLocationUC: getLocationUC,
  );
});

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required GetFeedPostsUC getFeedPostsUC,
    required GetLocationUC getLocationUC,
  })  : _getFeedPostsUC = getFeedPostsUC,
        _getLocationUC = getLocationUC,
        super(Loading()) {
    on<GetMap>(_getGeolocationAndFetchMap);
    on<TryAgain>(_getGeolocationAndFetchMap);
  }

  final GetFeedPostsUC _getFeedPostsUC;
  final GetLocationUC _getLocationUC;

  void _getGeolocationAndFetchMap(MapEvent event, Emitter emit) async {
    final permission = await Permission.location.status;
    if (permission == PermissionStatus.granted) {
      emit(Loading());
      try {
        final geolocation = await _getLocationUC.getFuture(NoParams());
        final postList = await _getFeedPostsUC.getFuture(NoParams());
        emit(
          Success(
            feedPostList: postList.map((post) => post.toVM()).toList(),
            geolocation: geolocation,
          ),
        );
      } catch (e) {
        emit(Error());
      }
    } else {
      emit(Error());
    }
  }
}
