
import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'colors/light_colors.dart';
part 'text_styles/light_text_styles.dart';
part 'assets/light_assets_paths.dart';

class LightAppTheme implements AppTheme {
  @override
  AppColors get colors => LightColors();

  @override
  AppTextStyles get textStyles => LightTextStyles();

  @override
  AppAssetsPaths get assets => LightAssetsPaths();
}

const _white = Color(0xFFFFFFFF);
const _black = Color(0xFF000000);
const _green = Color(0xFF06A94D);
const _graniteGray = Color(0xFF666666);

const _montserratFontFamily = 'Montserrat';