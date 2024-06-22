import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferences _sharedPrefs;

  SharedPreferencesRepository(this._sharedPrefs);

  Future<void> setLocale(Locale locale) async {
    await _sharedPrefs.setString(SharedPreferencesKeys.locale, locale.languageCode);
  }

  Locale getLocale() {
    String languageCode = _sharedPrefs.getString(SharedPreferencesKeys.locale) ?? 'en';
    return Locale(languageCode);
  }
}

class SharedPreferencesKeys {
  static const String locale = 'locale';
}

final sharedPreferencesProvider = Provider<SharedPreferencesRepository>((ref) {
  throw UnimplementedError();
});