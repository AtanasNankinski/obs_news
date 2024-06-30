import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('env/app_config.json');
    _config = jsonDecode(configString) as Map<String, dynamic>;
  }

  static bool isDebug() {
    String env = _config!["ENV"] as String;
    if(env == "DEV") return true;

    return false;
  }
}