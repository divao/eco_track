part of '../light_app_theme.dart';

class LightTextStyles implements AppTextStyles {
  @override
  TextStyle get profileInfo => const TextStyle(
    color: _black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: _interFontFamily,
  );
}
