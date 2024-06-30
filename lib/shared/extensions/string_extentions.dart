import 'package:obs_news/shared/navigation/routing_constants.dart';

extension StringExtentions on String {
  String loggedOutRoute() => "${RoutingPaths.loggedOut}/$this";
  String homeRoute() => "${RoutingPaths.home}/$this";
}