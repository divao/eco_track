import 'package:eco_track_whitelabel/data/view/model/feed_post_vm.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';

abstract class FeedState {}

class Success implements FeedState {
  Success({required this.feedPostList});

  final List<FeedPostVM> feedPostList;
}

class Loading implements FeedState {}

class Error implements FeedState, GenericErrorView {
  const Error(this.type);

  @override
  final GenericErrorViewType type;
}