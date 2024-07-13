import 'package:bloc/bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileBlocProvider = Provider.autoDispose<ProfileBloc>((ref) {
  return ProfileBloc();
});

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(Loading()) {
    on<GetProfile>(_fetchProfile);
    on<TryAgain>(_fetchProfile);
  }

  void _fetchProfile(ProfileEvent event, Emitter emit) async {
    emit(Loading());
  }
}