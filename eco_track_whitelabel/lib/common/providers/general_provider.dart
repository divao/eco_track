import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/presentation/common/app_theme/app_theme.dart';
import 'package:common/presentation/common/app_theme/light_app_theme.dart';
import 'package:domain/data_repository/auth_data_repository.dart';
import 'package:domain/data_repository/feed_data_repository.dart';
import 'package:domain/geo_locator.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_case/delete_user_uc.dart';
import 'package:domain/use_case/get_feed_posts_uc.dart';
import 'package:domain/use_case/get_location_uc.dart';
import 'package:domain/use_case/get_user_profile_uc.dart';
import 'package:domain/use_case/post_feed_post_uc.dart';
import 'package:domain/use_case/sign_in_uc.dart';
import 'package:domain/use_case/sign_out_uc.dart';
import 'package:domain/use_case/sign_up_uc.dart';
import 'package:domain/use_case/validate_name_uc.dart';
import 'package:domain/use_case/validate_email_uc.dart';
import 'package:domain/use_case/validate_password_uc.dart';
import 'package:domain/use_case/validate_password_confirmation_uc.dart';
import 'package:eco_track_whitelabel/common/analytics_logger.dart';
import 'package:eco_track_whitelabel/common/analytics_observer.dart';
import 'package:eco_track_whitelabel/common/locator.dart' as locator;
import 'package:eco_track_whitelabel/data/remote/data_source/auth_rds.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/feed_rds.dart';
import 'package:eco_track_whitelabel/data/remote/data_source/user_rds.dart';
import 'package:eco_track_whitelabel/data/repository/auth_repository.dart';
import 'package:eco_track_whitelabel/data/repository/feed_repository.dart';
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

final locatorProvider = Provider<GeoLocator>((ref){
  return locator.Locator();
});

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
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  return UserRDS(
    firebaseFirestore: firebaseFirestore,
    firebaseAuth: firebaseAuth,
    firebaseStorage: firebaseStorage,
  );
});

final feedRDSProvider = Provider<FeedRDS>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return FeedRDS(
    firebaseFirestore: firebaseFirestore,
    firebaseStorage: firebaseStorage,
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

final feedRepositoryProvider = Provider<FeedDataRepository>((ref) {
  final feedRDS = ref.watch(feedRDSProvider);
  final userRDS = ref.watch(userRDSProvider);
  return FeedRepository(
    feedRDS: feedRDS,
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

final validateNameUCProvider = Provider<ValidateNameUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  return ValidateNameUC(logger: logger);
});

final validateEmailUCProvider = Provider<ValidateEmailUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  return ValidateEmailUC(logger: logger);
});

final validatePasswordUCProvider = Provider<ValidatePasswordUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  return ValidatePasswordUC(logger: logger);
});

final validatePasswordConfirmationUCProvider =
    Provider<ValidatePasswordConfirmationUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  return ValidatePasswordConfirmationUC(logger: logger);
});

final getFeedPostsUCProvider = Provider<GetFeedPostsUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final repository = ref.watch(feedRepositoryProvider);
  return GetFeedPostsUC(
    logger: logger,
    repository: repository,
  );
});

final getLocationUCProvider = Provider<GetLocationUC>((ref) {
  final locator = ref.watch(locatorProvider);
  final logger = ref.watch(errorLoggerProvider);
  return GetLocationUC(
    geoLocator: locator,
    logger: logger,
  );
});

final postFeedPostUCProvider = Provider<PostFeedPostUC>((ref) {
  final logger = ref.watch(errorLoggerProvider);
  final repository = ref.watch(feedRepositoryProvider);
  return PostFeedPostUC(
    logger: logger,
    feedDataRepository: repository,
  );
});


