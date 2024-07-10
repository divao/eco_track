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
  TextStyle get filledButton => const TextStyle(
    color: _white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

  @override
  TextStyle get textButton => const TextStyle(
    color: _green,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: _montserratFontFamily,
  );

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
}
