import 'dart:async';
import 'package:common/generated/l10n.dart';
import 'package:common/common/common_localizations.dart';
import 'package:common/presentation/common/app_theme/theme_extension.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import 'common/routing.dart';

class Log {
  Logger logger = Logger(printer: PrettyPrinter());

  Future<void> logError(
    String errorType,
    dynamic error, [
    StackTrace? stackTrace,
  ]) async {
    logger.e(errorType, error: error, stackTrace: stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final errorLogger = Log().logError;

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // TODO: tirar comentario apos configurar o firebase
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      //
      // await FirebaseCrashlytics.instance
      //     .setCrashlyticsCollectionEnabled(!kDebugMode);
      //
      // if (!kDebugMode) {
      //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      // }
      //
      // await FirebaseAnalytics.instance.logAppOpen();

      await SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      );
      runApp(
        const ProviderScope(
          child: _MyApp(),
        ),
      );
    },
    (error, stackTrace) async {
      await errorLogger(
        'Zoned Guarded Error',
        error,
        stackTrace,
      );
    },
  );
}

class _MyApp extends ConsumerWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'EcoTrack',
      routerConfig: routes,
      localizationsDelegates: [
        S.delegate,
        CommonLocalizations.materialLocalization,
        CommonLocalizations.cupertinoLocalization,
        CommonLocalizations.widgetsLocalization,
      ],
      theme: ThemeData(
        primarySwatch: ref.colors.primaryColor,
      ),
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
