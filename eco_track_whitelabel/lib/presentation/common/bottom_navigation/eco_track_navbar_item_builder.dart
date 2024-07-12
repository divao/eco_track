import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'eco_track_navbar_item.dart';

class EcoTrackNavBarItemBuilder extends StatelessWidget {
  const EcoTrackNavBarItemBuilder({
    required this.index,
    required this.item,
    this.currentIndex,
    this.selectedItemBackgroundColor,
    this.unselectedItemBackgroundColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.onTap,
    this.buttonHeight,
    this.buttonWidth,
    this.iconSize = 24,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    super.key,
  });

  final int index;
  final int? currentIndex;
  final EcoTrackNavBarItem item;
  final Color? selectedItemBackgroundColor;
  final Color? unselectedItemBackgroundColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final void Function(int value)? onTap;
  final double? buttonWidth;
  final double? buttonHeight;
  final double iconSize;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(
              microseconds: 300,
            ),
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? selectedItemBackgroundColor
                  : unselectedItemBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: InkResponse(
              onTap: () => onTap?.call(index),
              radius: 32,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.icon != null)
                      Icon(
                        item.icon,
                        color: currentIndex == index
                            ? selectedIconColor
                            : unselectedIconColor,
                        size: iconSize,
                      ),
                    if (item.svgIcon != null && item.icon == null)
                      SvgPicture.asset(
                        item.svgIcon!,
                        colorFilter: ColorFilter.mode(
                          currentIndex == index
                              ? selectedIconColor ?? Colors.black
                              : unselectedIconColor ?? Colors.black,
                          BlendMode.srcIn,
                        ),
                        height: iconSize,
                      ),
                    Text(
                      item.title,
                      style: currentIndex == index
                          ? selectedTextStyle
                          : unselectedTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}