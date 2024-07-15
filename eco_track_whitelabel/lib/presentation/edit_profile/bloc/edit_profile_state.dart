import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/edit_profile_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_up_status.dart';

final class EditProfileState {
  const EditProfileState({
    required this.editProfileStatus,
    required this.buttonStatus,
    required this.name,
    required this.nameInputStatus,
    required this.email,
    required this.emailInputStatus,
    required this.imageUrl,
  });

  final EditProfileStatus editProfileStatus;
  final ButtonStatus buttonStatus;
  final String name;
  final InputStatus nameInputStatus;
  final String email;
  final InputStatus emailInputStatus;
  final String imageUrl;

  EditProfileState copyWith({
    EditProfileStatus? editProfileStatus,
    ButtonStatus? buttonStatus,
    String? name,
    String? email,
    InputStatus? nameInputStatus,
    InputStatus? emailInputStatus,
    String? imageUrl,
  }) {
    return EditProfileState(
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      name: name ?? this.name,
      nameInputStatus: nameInputStatus ?? this.nameInputStatus,
      email: email ?? this.email,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
