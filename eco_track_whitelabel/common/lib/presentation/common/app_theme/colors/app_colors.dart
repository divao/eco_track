part of '../app_theme.dart';

abstract class AppColors {
  static AppColors of(WidgetRef ref) {
    return AppTheme.of(ref).colors;
  }

  MaterialColor get primaryColor;

  Color get surfaceColor;

  // Bottom Navigation

  Color get bottomNavigationBarColor;

  Color get bottomNavigationBarSelectedIconColor;

  Color get bottomNavigationBarUnselectedIconColor;

  // Flush Bar

  Color get flushbarBackgroundColor;

  Color get flushbarIconColor;

  // Text Field

  Color get textFieldUnfocusedBorderColor;

  Color get textFieldFocusedBorderColor;

  Color get textFieldErrorBorderColor;

  Color get textFieldPasswordVisibilityIconColor;

  // EcoButton

  Color get filledGreenButtonColor;

  Color get buttonBorderColor;

  Color get buttonFilledGreenLoadingIndicatorColor;

  Color get buttonLoadingIndicatorColor;





}