import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/app.dart';
import 'package:obs_news/utility/config_reader.dart';
import 'package:obs_news/utility/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  await SharedPreferencesService().initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}