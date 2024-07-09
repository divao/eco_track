import 'package:eco_track_whitelabel/common/providers/general_provider.dart';
import 'package:eco_track_whitelabel/presentation/home/home_page.dart';
import 'package:eco_track_whitelabel/presentation/home_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _slash = '/';
const _feedPage = 'feed';
const _profilePage = 'profile';

const _feedPath = _slash + _feedPage;
const _profilePath = _slash + _profilePage;

final _goRouterNavigatorKey = GlobalKey<NavigatorState>();
final _feedNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final analyticsObserver = ref.watch(analyticsObserverProvider);
    return GoRouter(
      navigatorKey: _goRouterNavigatorKey,
      initialLocation: _feedPath,
      // observers: [
      //   analyticsObserver,
      // ],
      routes: [
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

extension GoRouterConsumerExtension on WidgetRef {
  GoRouter get goRouter => watch(goRouterProvider);
}

extension GoRouterStateExtension on ConsumerState {
  GoRouter get goRouter => ref.goRouter;
}
