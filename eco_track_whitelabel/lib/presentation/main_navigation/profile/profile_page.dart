import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/common/routing.dart';
import 'package:eco_track_whitelabel/data/mappers/view_to_domain.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/dialog_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/handler/flushbar_handler.dart';
import 'package:eco_track_whitelabel/presentation/common/state_response_view.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/delete_user_status.dart';
import 'package:eco_track_whitelabel/presentation/common/utils/status/sign_out_status.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({
    required this.bloc,
    super.key,
  });

  final ProfileBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) {
          final bloc = ref.watch(profileBlocProvider);
          return ProfilePage(bloc: bloc);
        },
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  ProfileBloc get _bloc => widget.bloc;

  final _platform = const MethodChannel('ecoTrack/systemOSVersion');
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfile());
  }

  Future<String> _getSystemOS() async {
    String systemOS = 'Sistema Operacional não reconhecido';
    final result = await _platform.invokeMethod<String>('getSystemOSVersion');
    if (result != null) {
      systemOS = result;
    }
    return systemOS;
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
      title: ref.s.profilePageTitle,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _bloc,
        listenWhen: (previous, current) => (current is Success &&
            (current.signOutStatus != SignOutStatus.idle ||
                current.deleteUserStatus != DeleteUserStatus.idle)),
        listener: (context, state) {
          if (state is Success) {
            if (state.signOutStatus == SignOutStatus.success ||
                state.deleteUserStatus == DeleteUserStatus.success) {
              ref.goRouter.goAccess();
            } else if (state.signOutStatus == SignOutStatus.error) {
              FlushbarHandler.instance.signOutErrorFlushbar(
                context,
                ref: ref,
              );
              _bloc.add(GetProfile());
            } else if (state.deleteUserStatus == DeleteUserStatus.error) {
              FlushbarHandler.instance.deleteUserErrorFlushbar(
                context,
                ref: ref,
              );
              _bloc.add(GetProfile());
            }
          }
        },
        builder: (context, state) => StateResponseView<Loading, Error, Success>(
              state: state,
              onTryAgainTap: () => _bloc.add(TryAgain()),
              successWidgetBuilder: (context, success) {
                return FutureBuilder(
                  future: _getSystemOS(),
                  builder: (context, snapshot) {
                    String systemOS = snapshot.data ?? '';
                    return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 54,
                                      backgroundImage: CachedNetworkImageProvider(
                                        success.profile.imageUrl,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      success.profile.name,
                                      style: ref.textStyles.profileName,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      success.profile.email,
                                      style: ref.textStyles.profileEmail,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      systemOS,
                                      style: ref.textStyles.profileSystemOS,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                EcoButton(
                                  text: ref.s.editProfileButton,
                                  buttonType: ButtonType.text,
                                  onPressed: () async {
                                    await ref.goRouter.pushEditProfile(
                                        profile: success.profile.toDM());
                                    _bloc.add(GetProfile());
                                  },
                                ),
                                const SizedBox(height: 12),
                                EcoButton(
                                  text: ref.s.deleteAccountButton,
                                  buttonType: ButtonType.text,
                                  onPressed: () {
                                    _passwordController.text = '';
                                    DialogHandler.instance.showDeleteUserDialog(
                                      context,
                                      ref,
                                      passwordController: _passwordController,
                                      passwordFocusNode: _passwordFocusNode,
                                      onConfirmPressed: (password) {
                                        _bloc.add(
                                          DeleteUser(password: password),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                EcoButton(
                                  text: ref.s.logoutButton,
                                  onPressed: () {
                                    DialogHandler.instance.showSignOutDialog(
                                      context,
                                      ref,
                                      onConfirmPressed: () {
                                        _bloc.add(
                                          SignOut(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                  }
                );
              }),
      ),
    );
  }
}
