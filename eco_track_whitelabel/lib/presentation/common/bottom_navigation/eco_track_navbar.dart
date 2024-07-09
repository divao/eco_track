import 'package:flutter/material.dart';

import 'eco_track_navbar_item.dart';
import 'eco_track_navbar_item_builder.dart';

class EcoTrackNavBar extends StatelessWidget {
  const EcoTrackNavBar({
    required this.barItems,
    this.backgroundColor,
    this.width,
    this.height,
    this.currentIndex,
    this.onTap,
    this.unselectedItemBackgroundColor,
    this.selectedItemBackgroundColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.buttonHeight,
    this.buttonWidth,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    super.key,
  });

  final List<EcoTrackNavBarItem> barItems;
  final Color? backgroundColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final void Function(int value)? onTap;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? selectedItemBackgroundColor;
  final Color? unselectedItemBackgroundColor;
  final int? currentIndex;
  final double? width;
  final double? height;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: barItems
              .asMap()
              .map((index, item) {
            return MapEntry(
              index,
              EcoTrackNavBarItemBuilder(
                key: item.key,
                index: index,
                item: item,
                onTap: onTap,
                buttonHeight: buttonHeight,
                buttonWidth: buttonWidth,
                currentIndex: currentIndex,
                selectedItemBackgroundColor: selectedItemBackgroundColor,
                unselectedItemBackgroundColor:
                unselectedItemBackgroundColor,
                selectedIconColor: selectedIconColor,
                unselectedIconColor: unselectedIconColor,
                selectedTextStyle: selectedTextStyle,
                unselectedTextStyle: unselectedTextStyle,
              ),
            );
          })
              .values
              .toList(),
        ),
      ),
    );
  }
}
