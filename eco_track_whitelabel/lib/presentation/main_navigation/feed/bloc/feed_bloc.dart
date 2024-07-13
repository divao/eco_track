import 'package:bloc/bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/bloc/feed_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedBlocProvider = Provider.autoDispose<FeedBloc>((ref) {
  return FeedBloc();
});

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(Loading()) {
    on<GetFeed>(_fetchFeed);
    on<TryAgain>(_fetchFeed);
  }

  void _fetchFeed(FeedEvent event, Emitter emit) async {
    emit(Loading());
  }
}