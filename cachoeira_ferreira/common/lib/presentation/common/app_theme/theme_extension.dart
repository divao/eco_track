import 'package:common/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';

extension RefTheme on WidgetRef {
  AppColors get colors => AppTheme.of(this).colors;

  AppAssetsPaths get assets => AppTheme.of(this).assets;

  AppTextStyles get textStyles => AppTheme.of(this).textStyles;

  S get s => S.of(context);
}

extension ThemeExtension on ConsumerState {
  AppColors get colors => ref.colors;

  AppAssetsPaths get assets => ref.assets;

  AppTextStyles get textStyles => ref.textStyles;

  S get s => ref.s;
}