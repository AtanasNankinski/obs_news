import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/app.dart';
import 'package:obs_news/utility/config_reader.dart';
import 'package:obs_news/utility/utility_repositories/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          SharedPreferencesRepository(sharedPreferences),
        ),
      ],
      child: const MyApp(),
    ),
  );
}