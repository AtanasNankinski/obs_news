import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:obs_news/features/splash_screen/splash_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:obs_news/features/authentication/login_page.dart';
import 'package:obs_news/features/authentication/sign_in_page.dart';
import 'package:obs_news/features/authentication/sign_in_with_email_page.dart';
import 'package:obs_news/features/news/news_page.dart';
import 'package:obs_news/features/splash_screen/splash_screen_page.dart';
import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/features/authentication/auth_repository_impl.dart';

part 'go_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
Raw<GoRouter> router(RouterRef ref) {
  final auth = ref.watch(userProvider);
  final splashState = ref.watch(splashControllerProvider);

  return GoRouter(
    initialLocation: splashState ? RoutingConst.home : RoutingConst.splashRoute,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    observers: [AppNavigatorObserver(ref)],
    redirect: (context, state) {
      final location = state.uri.toString();
      final isAuth = auth.valueOrNull != null;
      final isInLoggedOut = location.contains(RoutingConst.loggedOut);

      if(auth.isLoading || auth.hasError) {
        return location;
      }

      //Fix for issue where on redirect the GoRouter is rebuild again and is calling the initial route
      //a.k.a. calling the splash screen again.
      if(location.contains(RoutingConst.splashRoute)) {
        return location;
      }
      if(!isAuth && !isInLoggedOut) return RoutingConst.loggedOut;

      return location;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingConst.splashRoute,
        path: RoutingConst.splashRoute,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: SplashScreenPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingConst.loggedOut,
        path: RoutingConst.loggedOut,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: SignInPage(),
        ),
        routes: [
          GoRoute(
            parentNavigatorKey: navigatorKey,
            name: RoutingConst.login,
            path: RoutingConst.login,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: LoginPage(),
            ),
          ),
          GoRoute(
            parentNavigatorKey: navigatorKey,
            name: RoutingConst.signInWithEmail,
            path: RoutingConst.signInWithEmail,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: SignInWithEmailPage(),
            ),
          ),
        ]
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        name: RoutingConst.home,
        path: RoutingConst.home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
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