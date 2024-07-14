import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_button.dart';
import 'package:eco_track_whitelabel/presentation/common/state_response_view.dart';
import 'package:eco_track_whitelabel/presentation/eco_scaffold.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_bloc.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_event.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return EcoScaffold(
      title: ref.s.profilePageTitle,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _bloc,
        builder: (context, state) {
          return StateResponseView<Loading, Error, Success>(
              state: state,
              onTryAgainTap: () => _bloc.add(TryAgain()),
              successWidgetBuilder: (context, success) => Padding(
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
                              onPressed: () {},
                            ),
                            const SizedBox(height: 12),
                            EcoButton(
                              text: ref.s.deleteAccountButton,
                              buttonType: ButtonType.text,
                              onPressed: () {},
                            ),
                            const SizedBox(height: 12),
                            EcoButton(
                              text: ref.s.logoutButton,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
