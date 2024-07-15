import 'package:bloc/bloc.dart';
import 'package:domain/model/user_profile.dart';
import 'package:domain/use_case/edit_profile_uc.dart';
import 'package:domain/use_case/validate_name_uc.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/edit_profile_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileBlocProvider =
    Provider.family.autoDispose<EditProfileBloc, UserProfile>((ref, profile) {
  final validateNameUC = ref.watch(validateNameUCProvider);
  final editProfileUC = ref.watch(editProfileUCProvider);
  return EditProfileBloc(
    validateNameUC: validateNameUC,
    editProfileUC: editProfileUC,
    profile: profile,
  );
});

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({
    required ValidateNameUC validateNameUC,
    required EditProfileUC editProfileUC,
    required UserProfile profile,
  })  : _validateNameUC = validateNameUC,
        _editProfileUC = editProfileUC,
        _profile = profile,
        super(
          EditProfileState(
            editProfileStatus: EditProfileStatus.idle,
            buttonStatus: ButtonInactive(),
            name: '',
            nameInputStatus: InputStatus.undefined,
            email: '',
            emailInputStatus: InputStatus.undefined,
            imageUrl: '',
          ),
        ) {
    on<SetProfileFields>(_onSetProfileFields);
    on<NameChanged>(_onNameChanged);
    on<EditProfileSubmitted>(_onEditProfileSubmitted);
  }

  final ValidateNameUC _validateNameUC;
  final EditProfileUC _editProfileUC;
  final UserProfile _profile;

  Future<void> _onSetProfileFields(SetProfileFields event, Emitter emit) async {
    emit(
      state.copyWith(
        name: _profile.name,
        nameInputStatus: InputStatus.valid,
        email: _profile.email,
        emailInputStatus: InputStatus.valid,
        imageUrl: _profile.imageUrl,
        buttonStatus: ButtonActive(),
      ),
    );
  }

  Future<void> _onNameChanged(NameChanged event, Emitter emit) async {
    await _updateNameInputStatus(event.name, emit);
    if (state.nameInputStatus == InputStatus.valid) {
      emit(
        state.copyWith(
          buttonStatus: ButtonActive(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          buttonStatus: ButtonInactive(),
        ),
      );
    }
  }

  Future<void> _updateNameInputStatus(String name, Emitter emit) async {
    try {
      await _validateNameUC.getFuture(
        ValidateNameUCParams(name),
      );
      emit(
        state.copyWith(
          name: name,
          nameInputStatus: InputStatus.valid,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          name: name,
          nameInputStatus: mapToInputStatus(e),
        ),
      );
    }
  }

  void _onEditProfileSubmitted(EditProfileSubmitted event, Emitter emit) async {
    emit(
      state.copyWith(
        buttonStatus: ButtonLoading(),
      ),
    );
    try {
      await _editProfileUC.getFuture(
        EditProfileUCParams(
          name: event.name,
          profileImage: event.profileImage,
        ),
      );
      emit(
        state.copyWith(
          buttonStatus: ButtonInactive(),
          editProfileStatus: EditProfileStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          buttonStatus: ButtonActive(),
          editProfileStatus: EditProfileStatus.error,
        ),
      );
    }
  }
}
