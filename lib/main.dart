import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:obs_news/app.dart';
import 'package:obs_news/features/authentication/auth_repository_impl.dart';
import 'package:obs_news/shared/shared_preferences/shared_preferences_repository.dart';
import 'package:obs_news/shared/utility/config_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: options,
  );

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

const FirebaseOptions options = FirebaseOptions(
  apiKey: 'AIzaSyCICKCsmCbsMZC3H-BQWXs2PJGemus30lk',
  messagingSenderId: '576626303302',
  appId: '1:576626303302:android:0dbe0253703069725c8547',
  projectId: 'obs-news-dev',
);