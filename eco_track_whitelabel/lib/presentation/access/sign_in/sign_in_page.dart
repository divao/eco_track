import 'package:common/generated/l10n.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/bloc/sign_in_bloc.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/bloc/sign_in_state.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_text_field.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/button_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/input_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_in_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc/sign_in_event.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({
    required this.bloc,
    super.key,
  });

  final SignInBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(signInBlocProvider);
          return SignInPage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  SignInBloc get _bloc => widget.bloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(InputStatus status) {
    final s = S.of(context);
    final validateMap = {
      InputStatus.empty: null,
      InputStatus.valid: null,
      InputStatus.invalid: null,
      InputStatus.wrong: s.signInWrongCredentialsError,
    };

    return validateMap[status];
  }

  String? _validatePassword(InputStatus status) {
    final s = S.of(context);
    final validateMap = {
      InputStatus.empty: null,
      InputStatus.valid: null,
      InputStatus.invalid: s.signInWrongCredentialsError,
      InputStatus.wrong: s.signInWrongCredentialsError,
    };

    return validateMap[status];
  }

  void _onSignInFailed(SignInStatus status, BuildContext context) {
    if (status == SignInStatus.undefined) {
      FlushbarHandler.instance.serverErrorFlushbar(
        context,
        ref: ref,
      );
      return;
    }
    if (status == SignInStatus.invalidEmailOrPassword) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ref.s.signInPageTitle,
            style: ref.textStyles.appBarTitle,
          ),
          backgroundColor: ref.colors.primaryColor,
          iconTheme: IconThemeData(color: ref.colors.surfaceColor),
        ),
        backgroundColor: ref.colors.surfaceColor,
        body: BlocListener<SignInBloc, SignInState>(
          bloc: _bloc,
          listenWhen: (previous, current) =>
              previous.signInStatus != current.signInStatus,
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.success) {
              ref.goRouter.goFeed();
            } else if (state.signInStatus != SignInStatus.idle) {
              _onSignInFailed(state.signInStatus, context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BlocBuilder<SignInBloc, SignInState>(
                  bloc: _bloc,
                  buildWhen: (previous, current) =>
                      previous.emailInputStatus != current.emailInputStatus,
                  builder: (context, state) {
                    return EcoTextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onChanged: (email) => _bloc.add(EmailChanged(email, _passwordController.text)),
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        _passwordFocusNode,
                      ),
                      labelText: s.signInEmailLabel,
                      hintText: s.signInEmailHintText,
                      errorText: _validateEmail(state.emailInputStatus),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<SignInBloc, SignInState>(
                  bloc: _bloc,
                  buildWhen: (previous, current) =>
                      previous.passwordInputStatus != current.passwordInputStatus,
                  builder: (context, state) {
                    return EcoTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onChanged: (password) =>
                          _bloc.add(PasswordChanged(_emailController.text, password)),
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      labelText: s.signInPasswordLabel,
                      hintText: s.signInPasswordHintText,
                      errorText: _validatePassword(state.passwordInputStatus),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<SignInBloc, SignInState>(
                    bloc: _bloc,
                    buildWhen: (previous, current) =>
                        previous.buttonStatus != current.buttonStatus,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          EcoButton(
                            onPressed: state.buttonStatus is ButtonActive
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    _bloc.add(SignInSubmitted(
                                        _emailController.text,
                                        _passwordController.text));
                                  }
                                : null,
                            isLoading: state.buttonStatus is ButtonLoading,
                            text: ref.s.signInPageSignInButton,
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
