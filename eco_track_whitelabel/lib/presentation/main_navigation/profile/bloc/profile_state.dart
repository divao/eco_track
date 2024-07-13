import 'package:eco_track_whitelabel/data/view/model/profile_vm.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/generic_error_view.dart';

abstract class ProfileState {}

class Success implements ProfileState {
  Success({required this.profile});

  final ProfileVM profile;
}

class Loading implements ProfileState {}

class Error implements ProfileState, GenericErrorView {
  const Error(this.type);

  @override
  final GenericErrorViewType type;
}