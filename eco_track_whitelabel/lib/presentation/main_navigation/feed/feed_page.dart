import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_bloc.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Container();
  }
}