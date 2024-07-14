import 'package:camera_camera/camera_camera.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/post_status.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/post/bloc/post_bloc.dart';
import 'package:eco_track_whitelabel/presentation/post/bloc/post_event.dart';
import 'package:eco_track_whitelabel/presentation/post/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerStatefulWidget {
  const PostPage({
    required this.bloc,
    super.key,
  });

  static Widget create({required Geolocation geolocation}) => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(postBlocProvider(geolocation));
          return PostPage(bloc: bloc);
        },
      );

  final PostBloc bloc;

  @override
  ConsumerState<PostPage> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  PostBloc get _bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      bloc: _bloc,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PostStatus.success) {
          ref.goRouter.goFeed();
        } else if (state.status == PostStatus.error) {
          // show error
        }
      },
      builder: (context, state) {
        if (state.status == PostStatus.camera) {
          return CameraCamera(
            mode: CameraMode.ratio4s3,
            resolutionPreset: ResolutionPreset.high,
            onFile: (file) {
              _bloc.add(TakePhoto(file: file));
            },
          );
        } else if (state.status == PostStatus.preview) {
          return EcoScaffold(
            title: ref.s.postPreviewTitle,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.file(
                    state.file!,
                    width: MediaQuery.of(context).size.width,
                  ),
                  EcoButton(
                    text: ref.s.postButton,
                    onPressed: () {
                      _bloc.add(Post());
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state.status == PostStatus.loading) {
          return EcoScaffold(
            title: ref.s.postPreviewTitle,
            body: Center(
              child: CircularProgressIndicator(
                color: ref.colors.primaryColor,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
