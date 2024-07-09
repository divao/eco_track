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

  // Bottom Navigation

  @override
  Color get bottomNavigationBarColor => _white;

  @override
  Color get bottomNavigationBarSelectedIconColor => _green;

  @override
  Color get bottomNavigationBarUnselectedIconColor => _graniteGray;

}
