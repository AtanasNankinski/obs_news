import 'package:flutter/material.dart';

import 'package:obs_news/config_reader.dart';
import 'package:obs_news/navigation/routing.dart';
import 'package:obs_news/navigation/routing_constants.dart';
import 'package:obs_news/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: ConfigReader.isDebug(),
      onGenerateRoute: Routing.generateRoute,
      initialRoute: RoutingConst.splashRoute,
      theme: mainTheme,
    );
  }
}