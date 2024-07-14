import 'package:domain/model/geolocation.dart';
import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/access_page.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_in/sign_in_page.dart';
import 'package:eco_track_whitelabel/presentation/access/sign_up/sign_up_page.dart';
import 'package:eco_track_whitelabel/presentation/home_navigation_page.dart';
import 'package:eco_track_whitelabel/presentation/main_navigation/feed/feed_page.dart';
import 'package:eco_track_whitelabel/presentation/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _slash = '/';
const _feedPage = 'feed';
const _profilePage = 'profile';
const _accessPage = 'access';
const _signUpPage = 'signUp';
const _signInPage = 'signIn';
const _postPage = 'post/:latitude/:longitude';

const _feedPath = _slash + _feedPage;
const _profilePath = _slash + _profilePage;
const _accessPath = _slash + _accessPage;
const _signUpPath = _accessPath + _slash + _signUpPage;
const _signInPath = _accessPath + _slash + _signInPage;
const _postPath = _feedPath + _slash + _postPage;

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
                  builder: (context, state) => const Scaffold(
                    body: Center(
                      child: Text('Profile'),
                    ),
                  ),
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
}

extension GoRouterConsumerExtension on WidgetRef {
  GoRouter get goRouter => watch(goRouterProvider);
}

extension GoRouterStateExtension on ConsumerState {
  GoRouter get goRouter => ref.goRouter;
}
