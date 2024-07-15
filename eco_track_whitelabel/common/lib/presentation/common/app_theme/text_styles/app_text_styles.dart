part of '../app_theme.dart';

abstract class AppTextStyles {
  static AppTextStyles of(WidgetRef ref) {
    return AppTheme.of(ref).textStyles;
  }

  TextStyle get profileInfo;

  TextStyle get appBarTitle;

  TextStyle get errorText;

  // Bottom Navigation

  TextStyle get bottomNavigationSelectedText;

  TextStyle get bottomNavigationUnselectedText;

  // Flush Bar

  TextStyle get flushBarError;

  // Text Field

  TextStyle get textFieldErrorLabelStyle;

  TextStyle get textFieldFocusedLabelStyle;

  TextStyle get textFieldUnfocusedLabelStyle;

  TextStyle get textFieldInputTextStyle;

  TextStyle get textFieldHintTextStyle;

  // EcoButton

  TextStyle get outlinedButtonTextStyle;

  TextStyle get textButtonTextStyle;

  TextStyle get filledGreenButtonTextStyle;

  // Dialog

  TextStyle get dialogTitleTextStyle;

  TextStyle get dialogContentTextStyle;

  TextStyle get dialogButtonTextStyle;

  // Feed

  TextStyle get feedPostUserName;

  TextStyle get feedPostDescription;

  TextStyle get feedPostGeolocation;

  // Profile

  TextStyle get profileName;

  TextStyle get profileEmail;

  TextStyle get profileSystemOS;

}
