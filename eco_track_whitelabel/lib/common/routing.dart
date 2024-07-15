import 'package:domain/model/geolocation.dart';
import 'package:domain/model/user_profile.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/access_page.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/sign_in_page.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/sign_up_page.dart';
import 'package:eco_track_whitelabel/presentation/edit_profile/edit_profile_page.dart';
import 'package:eco_track_whitelabel/presentation/home_navigation_page.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/feed_page.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/profile/profile_page.dart';
import 'package:eco_track_whitelabel/presentation/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _slash = '/';

// Feed
const _feedPage = 'feed';
const _postPage = 'post/:latitude/:longitude';

// Profile
const _profilePage = 'profile';
const _editProfilePage = 'editProfile/:name/:email/:imageUrl';

// Access
const _accessPage = 'access';
const _signUpPage = 'signUp';
const _signInPage = 'signIn';

// Feed
const _feedPath = _slash + _feedPage;
const _postPath = _feedPath + _slash + _postPage;

// Profile
const _profilePath = _slash + _profilePage;
const _editProfilePath = _profilePath + _slash + _editProfilePage;

// Access
const _accessPath = _slash + _accessPage;
const _signUpPath = _accessPath + _slash + _signUpPage;
const _signInPath = _accessPath + _slash + _signInPage;

final _goRouterNavigatorKey = GlobalKey<NavigatorState>();
final _feedNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final analyticsObserver = ref.watch(analyticsObserverProvider);
    final auth = ref.watch(firebaseAuthProvider);
    return GoRouter(
      navigatorKey: _goRouterNavigatorKey,
      initialLocation: _feedPath,
      observers: [
        analyticsObserver,
      ],
      redirect: (_, state) async {
        if (auth.currentUser == null) {
          if (state.uri.toString() != _signInPath &&
              state.uri.toString() != _signUpPath) {
            return _accessPath;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: _accessPath,
          builder: (context, state) => const AccessPage(),
          routes: [
            GoRoute(
              path: _signInPage,
              builder: (context, state) => SignInPage.create(),
            ),
            GoRoute(
              path: _signUpPage,
              builder: (context, state) => SignUpPage.create(),
            ),
          ],
        ),
        StatefulShellRoute.indexedStack(
          branches: [
            StatefulShellBranch(
              navigatorKey: _feedNavigatorKey,
              routes: [
                GoRoute(
                  path: _feedPath,
                  builder: (context, state) => FeedPage.create(),
                  routes: [
                    GoRoute(
                      path: _postPage,
                      builder: (context, state) => PostPage.create(
                        geolocation: Geolocation(
                          latitude: double.parse(
                              state.pathParameters['latitude'] ?? '0'),
                          longitude: double.parse(
                              state.pathParameters['longitude'] ?? '0'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _profileNavigatorKey,
              routes: [
                GoRoute(
                  path: _profilePath,
                  builder: (context, state) => ProfilePage.create(),
                  routes: [
                    GoRoute(
                      path: _editProfilePage,
                      builder: (context, state) {
                        final profile = state.extra as UserProfile;
                        return EditProfilePage.create(
                        profile: UserProfile(
                          name: profile.name,
                          email: profile.email,
                          imageUrl: profile.imageUrl,
                        ),
                      );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
          builder: (context, state, navigationShell) => HomeNavigationPage(
            feedNavigatorKey: _feedNavigatorKey,
            profileNavigatorKey: _profileNavigatorKey,
            navigationShell: navigationShell,
          ),
        ),
      ],
    );
  },
);

extension PageNavigationExtension on GoRouter {
  void goAccess() => go(_accessPath);

  void goSignIn() => go(_signInPath);

  void goSignUp() => go(_signUpPath);

  void goFeed() => go(_feedPath);

  void goProfile() => go(_profilePath);

  Future<void> pushPost({required Geolocation geolocation}) async {
    final postPath = _postPath
        .replaceFirst(':latitude', geolocation.latitude.toString())
        .replaceFirst(':longitude', geolocation.longitude.toString());
    await push(postPath);
  }

  Future<void> pushEditProfile({required UserProfile profile}) async {
    await push(_editProfilePath, extra: profile);
  }
}

extension GoRouterConsumerExtension on WidgetRef {
  GoRouter get goRouter => watch(goRouterProvider);
}

extension GoRouterStateExtension on ConsumerState {
  GoRouter get goRouter => ref.goRouter;
}
