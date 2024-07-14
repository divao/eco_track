import 'package:bloc/bloc.dart';
import 'package:domain/model/geolocation.dart';
import 'package:domain/use_case/post_feed_post_uc.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/post_status.dart';
import 'package:eco_track_whitelabel/presentation/post/bloc/post_event.dart';
import 'package:eco_track_whitelabel/presentation/post/bloc/post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postBlocProvider = Provider.family.autoDispose<PostBloc, Geolocation>((ref, geolocation) {
  final postFeedPostUC = ref.watch(postFeedPostUCProvider);
  return PostBloc(
    postFeedPostUC: postFeedPostUC,
    geolocation: geolocation,
  );
});

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required PostFeedPostUC postFeedPostUC,
    required Geolocation geolocation,
  })  : _postFeedPostUC = postFeedPostUC,
        _geolocation = geolocation,
        super(
          const PostState(
            status: PostStatus.camera,
            file: null,
          ),
        ) {
    on<TakePhoto>(_onTakePhoto);
    on<Post>(_onPost);
  }

  final PostFeedPostUC _postFeedPostUC;
  final Geolocation _geolocation;

  Future<void> _onTakePhoto(TakePhoto event, Emitter emit) async {
    emit(
      state.copyWith(
        status: PostStatus.preview,
        file: event.file,
      ),
    );
  }

  Future<void> _onPost(Post event, Emitter emit) async {
    emit(
      state.copyWith(
        status: PostStatus.loading,
      ),
    );
    try {
      await _postFeedPostUC.getFuture(
        PostFeedPostUCParams(
          file: state.file!,
          description: event.description,
          geolocation: _geolocation,
        ),
      );
      emit(
        state.copyWith(
          status: PostStatus.success,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PostStatus.error,
        ),
      );
    }
  }
}
