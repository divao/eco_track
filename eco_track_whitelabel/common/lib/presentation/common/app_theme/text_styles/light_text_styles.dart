part of '../light_app_theme.dart';

class LightTextStyles implements AppTextStyles {
  @override
  TextStyle get profileInfo => const TextStyle(
    color: _black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get appBarTitle => const TextStyle(
    color: _white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: _montserratFontFamily,
  );

  // Bottom Navigation

  @override
  TextStyle get bottomNavigationSelectedText => const TextStyle(
    color: _green,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get bottomNavigationUnselectedText => const TextStyle(
    color: _graniteGray,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  // Flush Bar

  @override
  TextStyle get flushBarError => const TextStyle(
    color: _white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  // Text Field

  @override
  TextStyle get textFieldErrorLabelStyle => const TextStyle(
    color: _firebrick,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textFieldFocusedLabelStyle => const TextStyle(
    color: _green,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textFieldUnfocusedLabelStyle => const TextStyle(
    color: _white,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textFieldInputTextStyle => const TextStyle(
    color: _black,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textFieldHintTextStyle => const TextStyle(
    color: _black,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  // EcoButton

  @override
  TextStyle get outlinedButtonTextStyle => const TextStyle(
    color: _green,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textButtonTextStyle => const TextStyle(
    color: _green,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get filledGreenButtonTextStyle => const TextStyle(
    color: _white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );
}
