import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'common/bottom_navigation/eco_track_navbar_item.dart';
import 'common/bottom_navigation/eco_track_navbar_scaffold.dart';
import 'common/eco_track_view_keys.dart';

class HomeNavigationPage extends ConsumerStatefulWidget {
  const HomeNavigationPage({
    required this.navigationShell,
    required this.feedNavigatorKey,
    required this.mapNavigatorKey,
    required this.profileNavigatorKey,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final GlobalKey<NavigatorState> feedNavigatorKey;
  final GlobalKey<NavigatorState> mapNavigatorKey;
  final GlobalKey<NavigatorState> profileNavigatorKey;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends ConsumerState<HomeNavigationPage> {
  StatefulNavigationShell get _navigationShell => widget.navigationShell;

  GlobalKey<NavigatorState> get _feedNavigatorKey => widget.feedNavigatorKey;

  GlobalKey<NavigatorState> get _mapNavigatorKey => widget.mapNavigatorKey;

  GlobalKey<NavigatorState> get _profileNavigatorKey =>
      widget.profileNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return EcoTrackNavBarScaffold(
      navigationShell: _navigationShell,
      navigationBarItems: [
        EcoTrackNavBarItem(
          key: EcoTrackViewKeys.ecoTrackBottomNavigationBarFeed,
          icon: Icons.feed_outlined,
          title: s.bottomNavigationFeedItem,
          navigatorKey: _feedNavigatorKey,
        ),
        EcoTrackNavBarItem(
          key: EcoTrackViewKeys.ecoTrackBottomNavigationBarMap,
          icon: Icons.map,
          title: s.bottomNavigationMapItem,
          navigatorKey: _mapNavigatorKey,
        ),
        EcoTrackNavBarItem(
          key: EcoTrackViewKeys.ecoTrackBottomNavigationBarProfile,
          icon: Icons.account_circle_outlined,
          title: s.bottomNavigationProfileItem,
          navigatorKey: _profileNavigatorKey,
        ),
      ],
    );
  }
}
