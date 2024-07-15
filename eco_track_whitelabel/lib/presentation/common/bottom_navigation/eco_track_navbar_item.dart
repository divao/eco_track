import 'package:flutter/material.dart';

class EcoTrackNavBarItem {
  EcoTrackNavBarItem({
    required this.navigatorKey,
    required this.title,
    this.icon,
    this.svgIcon,
    this.key,
  });

  Key? key;
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;
}
