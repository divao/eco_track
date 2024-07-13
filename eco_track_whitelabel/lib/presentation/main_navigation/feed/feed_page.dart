import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_track_whitelabel/presentation/common/state_response_view.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
      title: ref.s.appTitle,
      body: BlocBuilder<FeedBloc, FeedState>(
          bloc: _bloc,
          builder: (context, state) {
            return StateResponseView<Loading, Error, Success>(
                state: state,
                onTryAgainTap: () => _bloc.add(TryAgain()),
                successWidgetBuilder: (context, success) {
                  final postList = success.feedPostList;
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              Text(postList[index].name),
                              CachedNetworkImage(
                                imageUrl: postList[index].imageUrl,
                                height: 200,
                              ),
                              Text(postList[index].description),
                              Text(
                                  '${postList[index].geolocation.latitude}, ${postList[index].geolocation.longitude}'),
                            ],
                          ));
                });
          }),
    );
  }
}
