import 'package:flutter/material.dart';
import 'package:obs_news/features/authentication/login_page.dart';

import 'package:obs_news/shared/navigation/routing_constants.dart';
import 'package:obs_news/features/splash_screen/splash_screen_page.dart';
import 'package:obs_news/features/authentication/sign_in_with_email_page.dart';
import 'package:obs_news/features/authentication/auth_control_widget.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutingConst.defaultRoute:
        return MaterialPageRoute(
          builder: (context) => const AuthControlWidget(),
          settings: settings,
        );
      case RoutingConst.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreenPage(),
          settings: settings,
        );
      case RoutingConst.signInWithEmail:
        return MaterialPageRoute(
          builder: (context) => SignInWithEmailPage(),
          settings: settings,
        );
      case RoutingConst.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const AuthControlWidget(),
          settings: settings,
        );
    }
  }
}