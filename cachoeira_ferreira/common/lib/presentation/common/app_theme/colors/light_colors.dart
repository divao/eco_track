part of '../light_app_theme.dart';

class LightColors implements AppColors {

  @override
  MaterialColor get primaryColor => MaterialColor(
    _blue.value,
    {
      50: _blue.withOpacity(.1),
      100: _blue.withOpacity(.2),
      200: _blue.withOpacity(.3),
      300: _blue.withOpacity(.4),
      400: _blue.withOpacity(.5),
      500: _blue.withOpacity(.6),
      600: _blue.withOpacity(.7),
      700: _blue.withOpacity(.8),
      800: _blue.withOpacity(.9),
      900: _blue.withOpacity(1),
    },
  );

  @override
  Color get surfaceColor => _white;

  @override
  Color get appBarBackgroundColor => _blue;

  @override
  Color get appBarContentColor => _white;

  @override
  Color get imagePlaceholderColor => _graniteGray;

  // Bottom Navigation

  @override
  Color get bottomNavigationBarColor => _white;

  @override
  Color get bottomNavigationBarSelectedIconColor => _blue;

  @override
  Color get bottomNavigationBarUnselectedIconColor => _graniteGray;

  // Flush Bar

  @override
  Color get flushbarBackgroundColor => _firebrick;

  @override
  Color get flushbarIconColor => _white;

  // Text Field

  @override
  Color get textFieldUnfocusedBorderColor => _blue;

  @override
  Color get textFieldFocusedBorderColor => _black;

  @override
  Color get textFieldErrorBorderColor => _firebrick;

  @override
  Color get textFieldPasswordVisibilityIconColor => _darkGray.withOpacity(0.6);

  // EcoButton

  @override
  Color get filledGreenButtonColor => _blue;

  @override
  Color get buttonBorderColor => _blue;

  @override
  Color get buttonFilledGreenLoadingIndicatorColor => _white;

  @override
  Color get buttonLoadingIndicatorColor => _blue;

}
