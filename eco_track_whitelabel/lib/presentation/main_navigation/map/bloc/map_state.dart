import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';

abstract class MapState {}

class Success implements MapState {
  Success({
    required this.feedPostList,
    required this.geolocation,
  });

  final List<FeedPostVM> feedPostList;
  final Geolocation geolocation;
}

class Loading implements MapState {}

class Error implements MapState {}
