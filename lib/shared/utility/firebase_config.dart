import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class FirebaseConfig {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('android/app/google-services.json');
    _config = jsonDecode(configString) as Map<String, dynamic>;
  }

  static FirebaseOptions getOptions() {
    String apiKey = _config!["client"][0]["api_key"][0]["current_key"];
    String messagingSenderId = _config!["project_info"]["project_number"];
    String appId = _config!["client"][0]["client_info"]["mobilesdk_app_id"];
    String projectId = _config!["project_info"]["project_id"];

    return FirebaseOptions(
      apiKey: apiKey,
      messagingSenderId: messagingSenderId,
      appId: appId,
      projectId: projectId,
    );
  }
}