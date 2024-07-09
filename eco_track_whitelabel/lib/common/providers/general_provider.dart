import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/light_app_theme.dart';
import 'package:domain/logger.dart';
import 'package:eco_track_whitelabel/common/analytics_logger.dart';
import 'package:eco_track_whitelabel/common/analytics_observer.dart';
import 'package:eco_track_whitelabel/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorLoggerProvider = Provider<ErrorLogger>((ref) => Log().logError);

final appThemeProvider = Provider<AppTheme>(
      (ref) => LightAppTheme(),
);

final _firebaseAnalyticsProvider =
Provider<FirebaseAnalytics>((ref) => FirebaseAnalytics.instance);

final analyticsLoggerProvider = Provider<AnalyticsLogger>((ref) {
  final firebaseAnalytics =
  ref.watch<FirebaseAnalytics>(_firebaseAnalyticsProvider);
  return AnalyticsLogger(logger: firebaseAnalytics);
});

final analyticsObserverProvider = Provider<AnalyticsObserver>((ref) {
  final analyticsLogger = ref.watch(analyticsLoggerProvider);
  return AnalyticsObserver(logger: analyticsLogger);
});