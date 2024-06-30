import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:obs_news/features/authentication/login_page.dart';
import 'package:obs_news/features/authentication/sign_in_page.dart';
import 'package:obs_news/features/authentication/sign_in_with_email_page.dart';
import 'package:obs_news/features/news/news_page.dart';
import 'package:obs_news/features/splash_screen/splash_screen_page.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/features/authentication/user_controller.dart';
import 'package:obs_news/features/splash_screen/splash_controller.dart';

part 'go_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
Raw<GoRouter> router(RouterRef ref) {
  final auth = ref.watch(userControllerProvider);
  final splashState = ref.watch(splashControllerProvider);

  return GoRouter(
    initialLocation: splashState ? RoutingPaths.home : RoutingPaths.splashRoute,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    observers: [AppNavigatorObserver(ref)],
    redirect: (context, state) async {
      final location = state.uri.toString();
      final isAuth = auth.valueOrNull != null;
      final isInLoggedOut = location.contains(RoutingPaths.loggedOut);

      if(auth.isLoading || auth.hasError) {
        return location;
      }

      //Fix for issue where on redirect the GoRouter is rebuild again and is calling the initial route
      //a.k.a. calling the splash screen again.
      if(location.contains(RoutingPaths.splashRoute)) {
        return location;
      }

      if(!isAuth && !isInLoggedOut) return RoutingPaths.loggedOut;

      return location;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingNames.splashRoute,
        path: RoutingPaths.splashRoute,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          name: state.fullPath,
          child: SplashScreenPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingNames.loggedOut,
        path: RoutingPaths.loggedOut,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          name: state.fullPath,
          child: SignInPage(),
        ),
        routes: [
          GoRoute(
            parentNavigatorKey: navigatorKey,
            name: RoutingNames.login,
            path: RoutingPaths.login,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              name: state.fullPath,
              child: LoginPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: navigatorKey,
            name: RoutingNames.signInWithEmail,
            path: RoutingPaths.signInWithEmail,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              name: state.fullPath,
              child: SignInWithEmailPage(),
            ),
          ),
        ]
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingNames.home,
        path: RoutingPaths.home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          name: state.fullPath,
          child: NewsPage(),
        ),
      ),
    ],
  );
}

class AppNavigatorObserver extends NavigatorObserver {
  final RouterRef ref;
  AppNavigatorObserver(this.ref);
}