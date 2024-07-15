import 'package:bloc/bloc.dart';
import 'package:domain/use_case/delete_user_uc.dart';
import 'package:domain/use_case/get_user_profile_uc.dart';
import 'package:domain/use_case/sign_out_uc.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/data/mappers/domain_to_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/delete_user_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_out_status.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileBlocProvider = Provider.autoDispose<ProfileBloc>((ref) {
  final getUserProfileUC = ref.watch(getUserProfileUCProvider);
  final deleteUserUC = ref.watch(deleteUserUCProvider);
  final signOutUC = ref.watch(signOutUCProvider);
  return ProfileBloc(
    getUserProfileUC: getUserProfileUC,
    deleteUserUC: deleteUserUC,
    signOutUC: signOutUC,
  );
});

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetUserProfileUC getUserProfileUC,
    required DeleteUserUC deleteUserUC,
    required SignOutUC signOutUC,
  })  : _getUserProfileUC = getUserProfileUC,
        _deleteUserUC = deleteUserUC,
        _signOutUC = signOutUC,
        super(Loading()) {
    on<GetProfile>(_onFetchProfile);
    on<TryAgain>(_onFetchProfile);
    on<SignOut>(_onSignOut);
    on<DeleteUser>(_onDeleteUser);
  }

  final GetUserProfileUC _getUserProfileUC;
  final DeleteUserUC _deleteUserUC;
  final SignOutUC _signOutUC;

  Future<void> _onFetchProfile(ProfileEvent event, Emitter emit) async {
    emit(Loading());
    try {
      final profile = await _getUserProfileUC.getFuture(NoParams());
      emit(Success(
        profile: profile.toVM(),
        signOutStatus: SignOutStatus.idle,
        deleteUserStatus: DeleteUserStatus.idle,
      ));
    } catch (e) {
      emit(Error(mapToGenericViewErrorType(e)));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter emit) async {
    final lastSuccessState = state as Success;
    emit(Loading());
    try {
      await _signOutUC.getFuture(NoParams());
      emit(lastSuccessState.copyWith(
        signOutStatus: SignOutStatus.success,
      ));
    } catch (e) {
      emit(lastSuccessState.copyWith(
        signOutStatus: SignOutStatus.error,
      ));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter emit) async {
    final lastSuccessState = state as Success;
    emit(Loading());
    try {
      await _deleteUserUC.getFuture(DeleteUserUCParams(deleteData: true, password: event.password));
      emit(lastSuccessState.copyWith(
        deleteUserStatus: DeleteUserStatus.success,
      ));
    } catch (e) {
      emit(lastSuccessState.copyWith(
        deleteUserStatus: DeleteUserStatus.error,
      ));
    }
  }
}
