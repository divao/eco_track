import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/light_app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = Provider<AppTheme>((ref) {
  return LightAppTheme();
});
