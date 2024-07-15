part of '../light_app_theme.dart';

class LightColors implements AppColors {

  @override
  MaterialColor get primaryColor => MaterialColor(
    _green.value,
    {
      50: _green.withOpacity(.1),
      100: _green.withOpacity(.2),
      200: _green.withOpacity(.3),
      300: _green.withOpacity(.4),
      400: _green.withOpacity(.5),
      500: _green.withOpacity(.6),
      600: _green.withOpacity(.7),
      700: _green.withOpacity(.8),
      800: _green.withOpacity(.9),
      900: _green.withOpacity(1),
    },
  );

  @override
  Color get surfaceColor => _white;

  @override
  Color get appBarBackgroundColor => _green;

  @override
  Color get appBarContentColor => _white;

  // Bottom Navigation

  @override
  Color get bottomNavigationBarColor => _white;

  @override
  Color get bottomNavigationBarSelectedIconColor => _green;

  @override
  Color get bottomNavigationBarUnselectedIconColor => _graniteGray;

  // Flush Bar

  @override
  Color get flushbarBackgroundColor => _firebrick;

  @override
  Color get flushbarIconColor => _white;

  // Text Field

  @override
  Color get textFieldUnfocusedBorderColor => _green;

  @override
  Color get textFieldFocusedBorderColor => _black;

  @override
  Color get textFieldErrorBorderColor => _firebrick;

  @override
  Color get textFieldPasswordVisibilityIconColor => _white.withOpacity(0.6);

  // EcoButton

  @override
  Color get filledGreenButtonColor => _green;

  @override
  Color get buttonBorderColor => _green;

  @override
  Color get buttonFilledGreenLoadingIndicatorColor => _white;

  @override
  Color get buttonLoadingIndicatorColor => _green;

}
