import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'analytics_logger.dart';

class AnalyticsObserver extends NavigatorObserver {
  AnalyticsObserver({
    required AnalyticsLogger logger,
  }) : _logger = logger;

  final AnalyticsLogger _logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('AnalyticsObserver: going to ${route.settings.name}');
    }
    _logger.logScreenView(screenName: route.settings.name ?? 'unknown');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('AnalyticsObserver: going back to ${previousRoute?.settings.name}');
    }
    _logger.logScreenView(
      screenName: previousRoute?.settings.name ?? 'unknown',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('AnalyticsObserver: going back to ${previousRoute?.settings.name}');
    }
    _logger.logScreenView(
      screenName: previousRoute?.settings.name ?? 'unknown',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (kDebugMode) {
      print('AnalyticsObserver: going to ${newRoute?.settings.name}');
    }
    _logger.logScreenView(
      screenName: newRoute?.settings.name ?? 'unknown',
    );
  }
}