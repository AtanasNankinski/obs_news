import 'package:flutter/material.dart';

import 'package:obs_news/app.dart';
import 'package:obs_news/config_reader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();

  runApp(const MyApp());
}