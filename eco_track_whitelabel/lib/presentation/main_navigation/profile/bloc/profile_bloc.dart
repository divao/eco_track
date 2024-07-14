import 'package:bloc/bloc.dart';
import 'package:domain/use_case/get_user_profile_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/data/mappers/domain_to_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileBlocProvider = Provider.autoDispose<ProfileBloc>((ref) {
  final getUserProfileUC = ref.watch(getUserProfileUCProvider);
  return ProfileBloc(
    getUserProfileUC: getUserProfileUC,
  );
});

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetUserProfileUC getUserProfileUC,
  })  : _getUserProfileUC = getUserProfileUC,
        super(Loading()) {
    on<GetProfile>(_fetchProfile);
    on<TryAgain>(_fetchProfile);
  }

  final GetUserProfileUC _getUserProfileUC;

  void _fetchProfile(ProfileEvent event, Emitter emit) async {
    emit(Loading());
    try {
      final profile = await _getUserProfileUC.getFuture(NoParams());
      emit(Success(
        profile: profile.toVM(),
      ));
    } catch (e) {
      emit(Error(mapToGenericViewErrorType(e)));
    }
  }
}
