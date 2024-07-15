import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/common/utils.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_text_field.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/debouncer.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/edit_profile_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({
    required this.bloc,
    super.key,
  });

  final EditProfileBloc bloc;

  static Widget create({
    required UserProfile profile,
  }) =>
      Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(editProfileBlocProvider(profile));
          return EditProfilePage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  EditProfileBloc get _bloc => widget.bloc;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  final imagePicker = ImagePicker();
  File? imageFile = null;

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(SetProfileFields());
  }

  String? _validateName(InputStatus status) {
    final statusMap = {
      InputStatus.empty: S.of(context).signUpNameEmptyError,
      InputStatus.invalid: S.of(context).signUpNameInvalidError,
      InputStatus.undefined: null,
    };
    return statusMap[status];
  }

  void _onEditProfileFailed(EditProfileStatus status, BuildContext context) {
    if (status == EditProfileStatus.error) {
      FlushbarHandler.instance.serverErrorFlushbar(
        context,
        ref: ref,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
        title: ref.s.editProfilePageTitle,
        body: BlocListener<EditProfileBloc, EditProfileState>(
          bloc: _bloc,
          listenWhen: (previous, current) =>
              previous.editProfileStatus != current.editProfileStatus,
          listener: (context, state) {
            if (state.editProfileStatus == EditProfileStatus.success) {
              ref.goRouter.pop();
            } else if (state.editProfileStatus != EditProfileStatus.idle) {
              _onEditProfileFailed(state.editProfileStatus, context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<EditProfileBloc, EditProfileState>(
                          bloc: _bloc,
                            builder: (context, state) {
                          return imageFile != null
                              ? CircleAvatar(
                                  radius: 54,
                                  backgroundImage: FileImage(imageFile!))
                              : CircleAvatar(
                                  radius: 54,
                                  backgroundImage: CachedNetworkImageProvider(
                                      state.imageUrl),
                                );
                        }),
                        const SizedBox(height: 8),
                        EcoButton(
                            text: ref.s.signUpPageUploadPhotoButton,
                            buttonType: ButtonType.text,
                            onPressed: () async {
                              final pickedFile = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  imageFile = File(pickedFile.path);
                                });
                              }
                            }),
                        const SizedBox(height: 8),
                        BlocConsumer<EditProfileBloc, EditProfileState>(
                          bloc: _bloc,
                          listenWhen: (previous, current) =>
                              previous.nameInputStatus !=
                              current.nameInputStatus,
                          listener: (context, state) => {
                            _nameController.text = state.name,
                          },
                          buildWhen: (previous, current) =>
                              previous.nameInputStatus !=
                              current.nameInputStatus,
                          builder: (context, state) {
                            return EcoTextField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              onChanged: (name) => _debouncer.run(
                                () => _bloc.add(
                                  NameChanged(name),
                                ),
                              ),
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              labelText: s.signUpNameLabel,
                              hintText: s.signUpNameHintText,
                              errorText: _validateName(state.nameInputStatus),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.name,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<EditProfileBloc, EditProfileState>(
                          bloc: _bloc,
                          listenWhen: (previous, current) =>
                              previous.emailInputStatus !=
                              current.emailInputStatus,
                          listener: (context, state) => {
                            _emailController.text = state.email,
                          },
                          builder: (context, state) {
                            return EcoTextField(
                              readOnly: true,
                              controller: _emailController,
                              labelText: s.signUpEmailLabel,
                              hintText: s.signUpEmailHintText,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<EditProfileBloc, EditProfileState>(
                    bloc: _bloc,
                    buildWhen: (previous, current) =>
                        previous.buttonStatus != current.buttonStatus,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          EcoButton(
                            onPressed: state.buttonStatus is ButtonActive
                                ? () async {
                                    FocusScope.of(context).unfocus();
                                    _bloc.add(
                                      EditProfileSubmitted(
                                        name: _nameController.text,
                                        profileImage: imageFile,
                                      ),
                                    );
                                  }
                                : null,
                            isLoading: state.buttonStatus is ButtonLoading,
                            text: ref.s.editProfilePageSubmitButton,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
