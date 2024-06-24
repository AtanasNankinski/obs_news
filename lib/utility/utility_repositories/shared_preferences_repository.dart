import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_preferences_repository.g.dart';

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

@riverpod
SharedPreferencesRepository sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}