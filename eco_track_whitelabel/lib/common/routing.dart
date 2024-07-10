import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/access/access_page.dart';
import 'package:eco_track_whitelabel/presentation/home/home_page.dart';
import 'package:eco_track_whitelabel/presentation/home_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _slash = '/';
const _feedPage = 'feed';
const _profilePage = 'profile';
const _accessPage = 'access';
const _signUpPage = 'signUp';
const _signInPage = 'signIn';

const _feedPath = _slash + _feedPage;
const _profilePath = _slash + _profilePage;
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
              // builder: (context, state) => SignInPage.create(),
              builder: (context, state) => HomePage.create(),
            ),
            GoRoute(
              path: _signUpPage,
              // builder: (context, state) => SignUpPage.create(),
              builder: (context, state) => HomePage.create(),
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
                  builder: (context, state) => HomePage.create(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _profileNavigatorKey,
              routes: [
                GoRoute(
                  path: _profilePath,
                  builder: (context, state) => HomePage.create(),
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
}

extension GoRouterConsumerExtension on WidgetRef {
  GoRouter get goRouter => watch(goRouterProvider);
}

extension GoRouterStateExtension on ConsumerState {
  GoRouter get goRouter => ref.goRouter;
}
