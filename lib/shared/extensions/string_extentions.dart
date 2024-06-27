import 'package:obs_news/shared/navigation/routing_constants.dart';

extension StringExtentions on String {
  String loggedOutRoute() => "${RoutingConst.loggedOut}/$this";
  String homeRoute() => "${RoutingConst.home}/$this";
}