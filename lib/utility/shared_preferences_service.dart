import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  static late SharedPreferences _prefs;

  SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLocale(Locale locale) async {
    switch(locale.languageCode){
      case 'en': await _prefs.setString(SharedPreferencesKeys.locale, 'en');
      break;
      case 'bg': await _prefs.setString(SharedPreferencesKeys.locale, 'bg');
      break;
      default: await _prefs.setString(SharedPreferencesKeys.locale, 'en');
      break;
    }
  }

  Locale getLocale() {
    String languageCode = _prefs.getString(SharedPreferencesKeys.locale) ?? 'en';
    return Locale(languageCode);
  }
}

class SharedPreferencesKeys {
  static const String locale = 'locale';
}