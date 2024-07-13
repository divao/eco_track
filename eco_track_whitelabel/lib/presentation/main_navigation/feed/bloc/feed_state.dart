import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/get_geolocation_status.dart';

abstract class FeedState {}

class Success implements FeedState {
  Success({
    required this.feedPostList,
    required this.getGeolocationStatus,
    this.geolocation,
  });

  final List<FeedPostVM> feedPostList;
  final GetGeolocationStatus getGeolocationStatus;
  final Geolocation? geolocation;

  Success copyWith({
    List<FeedPostVM>? feedPostList,
    GetGeolocationStatus? getGeolocationStatus,
    Geolocation? geolocation,
  }) =>
      Success(
        feedPostList: feedPostList ?? this.feedPostList,
        getGeolocationStatus: getGeolocationStatus ?? this.getGeolocationStatus,
        geolocation: geolocation ?? this.geolocation,
      );
}

class Loading implements FeedState {}

class Error implements FeedState, GenericErrorView {
  const Error(this.type);

  @override
  final GenericErrorViewType type;
}
