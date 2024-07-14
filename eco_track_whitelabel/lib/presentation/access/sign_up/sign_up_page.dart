import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/common/utils.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_bloc.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_event.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/bloc/sign_up_state.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_text_field.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/debouncer.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_up_status.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({
    required this.bloc,
    super.key,
  });

  final SignUpBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(signUpBlocProvider);
          return SignUpPage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  SignUpBloc get _bloc => widget.bloc;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();

  final imagePicker = ImagePicker();
  File? imageFile = null;

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    super.dispose();
  }

  String? _validateName(InputStatus status) {
    final statusMap = {
      InputStatus.empty: S.of(context).signUpNameEmptyError,
      InputStatus.invalid: S.of(context).signUpNameInvalidError,
      InputStatus.undefined: null,
    };
    return statusMap[status];
  }

  String? _validateEmail(InputStatus status) {
    final statusMap = {
      InputStatus.empty: S.of(context).signUpEmailEmptyError,
      InputStatus.invalid: S.of(context).signUpEmailInvalidError,
      InputStatus.undefined: null,
    };
    return statusMap[status];
  }

  String? _validatePassword(InputStatus status) {
    final statusMap = {
      InputStatus.empty: S.of(context).signUpPasswordEmptyError,
      InputStatus.invalid: S.of(context).signUpPasswordInvalidError,
      InputStatus.undefined: null,
    };
    return statusMap[status];
  }

  String? _validatePasswordConfirmation(InputStatus status) {
    final statusMap = {
      InputStatus.empty: S.of(context).signUpPasswordConfirmationEmptyError,
      InputStatus.invalid: S.of(context).signUpPasswordConfirmationInvalidError,
      InputStatus.undefined: null,
    };
    return statusMap[status];
  }

  void _onSignUpFailed(SignUpStatus status, BuildContext context) {
    if (status == SignUpStatus.undefinedError) {
      FlushbarHandler.instance.serverErrorFlushbar(
        context,
        ref: ref,
      );
      return;
    }
    if (status == SignUpStatus.emailAlreadyUsed) {
      FlushbarHandler.instance.emailAlreadyUsedErrorFlushbar(
        context,
        ref: ref,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
        title: ref.s.signUpPageTitle,
        body: BlocListener<SignUpBloc, SignUpState>(
          bloc: _bloc,
          listenWhen: (previous, current) =>
              previous.signUpStatus != current.signUpStatus,
          listener: (context, state) {
            if (state.signUpStatus == SignUpStatus.success) {
              ref.goRouter.goFeed();
            } else if (state.signUpStatus != SignUpStatus.idle) {
              _onSignUpFailed(state.signUpStatus, context);
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
                        imageFile != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(imageFile!))
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                    ref.assets.profilePlaceholderImage),
                              ),
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
                        BlocBuilder<SignUpBloc, SignUpState>(
                          bloc: _bloc,
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
                                  FocusScope.of(context).requestFocus(
                                _emailFocusNode,
                              ),
                              labelText: s.signUpNameLabel,
                              hintText: s.signUpNameHintText,
                              errorText: _validateName(state.nameInputStatus),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          bloc: _bloc,
                          buildWhen: (previous, current) =>
                              previous.emailInputStatus !=
                              current.emailInputStatus,
                          builder: (context, state) {
                            return EcoTextField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              onChanged: (email) => _debouncer.run(
                                () => _bloc.add(
                                  EmailChanged(email),
                                ),
                              ),
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(
                                _passwordFocusNode,
                              ),
                              labelText: s.signUpEmailLabel,
                              hintText: s.signUpEmailHintText,
                              errorText: _validateEmail(state.emailInputStatus),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          bloc: _bloc,
                          buildWhen: (previous, current) =>
                              previous.passwordInputStatus !=
                              current.passwordInputStatus,
                          builder: (context, state) {
                            return EcoTextField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              onChanged: (password) => _debouncer.run(
                                () => _bloc.add(
                                  PasswordChanged(
                                    password,
                                    _passwordConfirmationController.text,
                                  ),
                                ),
                              ),
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(
                                _passwordConfirmationFocusNode,
                              ),
                              labelText: s.signUpPasswordLabel,
                              hintText: s.signUpPasswordHintText,
                              errorText:
                                  _validatePassword(state.passwordInputStatus),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          bloc: _bloc,
                          buildWhen: (previous, current) =>
                              previous.passwordConfirmationInputStatus !=
                              current.passwordConfirmationInputStatus,
                          builder: (context, state) {
                            return EcoTextField(
                              controller: _passwordConfirmationController,
                              focusNode: _passwordConfirmationFocusNode,
                              onChanged: (passwordConfirmation) =>
                                  _debouncer.run(
                                () => _bloc.add(
                                  PasswordConfirmationChanged(
                                    _passwordController.text,
                                    passwordConfirmation,
                                  ),
                                ),
                              ),
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              labelText: s.signUpPasswordConfirmationLabel,
                              hintText: s.signUpPasswordConfirmationHintText,
                              errorText: _validatePasswordConfirmation(
                                state.passwordConfirmationInputStatus,
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<SignUpBloc, SignUpState>(
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
                                    final file = imageFile ?? await getImageFileFromAssets(ref.assets.profilePlaceholderImage);
                                    _bloc.add(
                                      SignUpSubmitted(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        profileImage: file,
                                      ),
                                    );
                                  }
                                : null,
                            isLoading: state.buttonStatus is ButtonLoading,
                            text: ref.s.signUpPageSignUpButton,
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
