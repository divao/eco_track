import 'package:eco_track_whitelabel/presentation/main_navigation/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Container();
  }
}