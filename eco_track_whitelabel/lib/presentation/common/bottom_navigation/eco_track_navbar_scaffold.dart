import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:eco_track_whitelabel/presentation/common/eco_track_view_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'eco_track_navbar.dart';
import 'eco_track_navbar_item.dart';

class EcoTrackNavBarScaffold extends ConsumerStatefulWidget {
  const EcoTrackNavBarScaffold({
    required this.navigationBarItems,
    required this.navigationShell,
    this.initialIndex,
    super.key,
  });

  final List<EcoTrackNavBarItem> navigationBarItems;
  final int? initialIndex;
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EcoTrackNavBarScaffoldState();
}

class _EcoTrackNavBarScaffoldState extends ConsumerState<EcoTrackNavBarScaffold> {
  StatefulNavigationShell get _navigationShell => widget.navigationShell;

  void _onTabSelected(int index) {
    _navigationShell.goBranch(
      index,
      initialLocation: index == _navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.surfaceColor,
      bottomNavigationBar: EcoTrackNavBar(
        key: EcoTrackViewKeys.ecoTrackBottomNavigationBar,
        barItems: widget.navigationBarItems,
        onTap: _onTabSelected,
        currentIndex: _navigationShell.currentIndex,
        backgroundColor: colors.bottomNavigationBarColor,
        height: 56,
        buttonHeight: 46,
        buttonWidth: 80,
        selectedIconColor: colors.bottomNavigationBarSelectedIconColor,
        unselectedIconColor: colors.bottomNavigationBarUnselectedIconColor,
        selectedTextStyle: textStyles.bottomNavigationSelectedText,
        unselectedTextStyle: textStyles.bottomNavigationUnselectedText,
      ),
      body: _navigationShell,
    );
  }
}