import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/light_app_theme.dart';
import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_case/delete_user_uc.dart';
import 'package:domain/use_case/get_user_profile_uc.dart';
import 'package:domain/use_case/sign_in_uc.dart';
import 'package:domain/use_case/sign_out_uc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:eco_track_whitelabel/common/analytics_logger.dart';
import 'package:eco_track_whitelabel/common/analytics_observer.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/auth_rds.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/user_rds.dart';
import 'package:eco_track_whitelabel/data/repository/auth_repository.dart';
import 'package:eco_track_whitelabel/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final firebaseStorageProvider = Provider<FirebaseStorage>(
  (ref) => FirebaseStorage.instance,
);

// RDS Providers

final authRDSProvider = Provider<AuthRDS>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  return AuthRDS(
    auth: firebaseAuth,
    firestore: firebaseFirestore,
  );
});

final userRDSProvider = Provider<UserRDS>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return UserRDS(
    firebaseFirestore: firebaseFirestore,
    firebaseAuth: firebaseAuth,
  );
});

// Repository Providers

final authRepositoryProvider = Provider<AuthDataRepository>((ref) {
  final authRDS = ref.watch(authRDSProvider);
  final userRDS = ref.watch(userRDSProvider);
  return AuthRepository(
    authRDS: authRDS,
    userRDS: userRDS,
  );
});

// UC Providers

final signInUCProvider = Provider<SignInUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUC(
    logger: logger,
    authRepository: authRepository,
  );
});

final signUpUCProvider = Provider<SignUpUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpUC(
    logger: logger,
    repository: authRepository,
  );
});

final getUserProfileUCProvider = Provider<GetUserProfileUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GetUserProfileUC(
    logger: logger,
    repository: authRepository,
  );
});

final signOutUCProvider = Provider<SignOutUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUC(
    logger: logger,
    repository: authRepository,
  );
});

final deleteUserUCProvider = Provider<DeleteUserUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final repository = ref.watch(authRepositoryProvider);
  return DeleteUserUC(
    logger: logger,
    repository: repository,
  );
});
