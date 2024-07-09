part of '../app_theme.dart';

abstract class AppColors {
  static AppColors of(WidgetRef ref) {
    return AppTheme.of(ref).colors;
  }

  MaterialColor get primaryColor;

  Color get surfaceColor;

}