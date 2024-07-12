part of '../light_app_theme.dart';

class LightColors implements AppColors {

  @override
  MaterialColor get primaryColor => MaterialColor(
    _cyan.value,
    {
      50: _cyan.withOpacity(.1),
      100: _cyan.withOpacity(.2),
      200: _cyan.withOpacity(.3),
      300: _cyan.withOpacity(.4),
      400: _cyan.withOpacity(.5),
      500: _cyan.withOpacity(.6),
      600: _cyan.withOpacity(.7),
      700: _cyan.withOpacity(.8),
      800: _cyan.withOpacity(.9),
      900: _cyan.withOpacity(1),
    },
  );

  @override
  Color get surfaceColor => _white;

}
