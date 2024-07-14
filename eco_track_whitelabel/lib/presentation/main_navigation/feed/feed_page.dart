import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/dialog_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/state_response_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/get_geolocation_status.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_state.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/widgets/feed_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({
    required this.bloc,
    super.key,
  });

  final FeedBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(feedBlocProvider);
          return FeedPage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  FeedBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetFeed());
  }

  void _requestPermissions() {
    DialogHandler.instance.showPermissionsInfoDialog(context, ref,
        onConfirmPressed: () {
      [Permission.location, Permission.camera].request().then(
        (statusMap) {
          if (statusMap[Permission.location] == PermissionStatus.granted &&
              statusMap[Permission.camera] == PermissionStatus.granted) {
            _bloc.add(GetGeolocation());
          } else if (statusMap[Permission.location] ==
                  PermissionStatus.permanentlyDenied ||
              statusMap[Permission.camera] ==
                  PermissionStatus.permanentlyDenied) {
            openAppSettings();
          } else {
            FlushbarHandler.instance
                .permissionsDeniedFlushbar(context, ref: ref);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
      title: ref.s.appTitle,
      body: BlocConsumer<FeedBloc, FeedState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is Success) {
              if (state.getGeolocationStatus == GetGeolocationStatus.success) {
                await ref.goRouter.pushPost(geolocation: state.geolocation!);
                _bloc.add(GetFeed());
              } else if (state.getGeolocationStatus ==
                  GetGeolocationStatus.error) {
                FlushbarHandler.instance
                    .geolocationErrorFlushbar(context, ref: ref);
              }
            }
          },
          builder: (context, state) {
            return StateResponseView<Loading, Error, Success>(
                state: state,
                onTryAgainTap: () => _bloc.add(TryAgain()),
                successWidgetBuilder: (context, success) {
                  final postList = success.feedPostList;
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) => FeedPostItem(
                          feedPost: postList[index],
                          isLast: index == postList.length - 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt_outlined),
                            iconSize: 36,
                            style: IconButton.styleFrom(
                              foregroundColor: ref.colors.surfaceColor,
                              backgroundColor: ref.colors.primaryColor,
                            ),
                            onPressed: () {
                              _requestPermissions();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
