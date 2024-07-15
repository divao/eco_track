import 'package:eco_track_whitelabel/data/view/model/profile_vm.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/delete_user_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_out_status.dart';

abstract class ProfileState {}

class Success implements ProfileState {
  Success({required this.profile, required this.signOutStatus, required this.deleteUserStatus});

  Success copyWith({
    ProfileVM? profile,
    SignOutStatus? signOutStatus,
    DeleteUserStatus? deleteUserStatus,
  }) {
    return Success(
      profile: profile ?? this.profile,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      deleteUserStatus: deleteUserStatus ?? this.deleteUserStatus,
    );
  }

  final ProfileVM profile;
  final SignOutStatus signOutStatus;
  final DeleteUserStatus deleteUserStatus;
}

class Loading implements ProfileState {}

class Error implements ProfileState, GenericErrorView {
  const Error(this.type);

  @override
  final GenericErrorViewType type;
}