import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:obs_news/utility/utility_repositories/shared_preferences_repository.dart';

part 'localization_controller.g.dart';

@riverpod
class LocalizationController extends _$LocalizationController {
  late SharedPreferencesRepository _sharedPrefs;

  @override
  Locale build() {
    _sharedPrefs = ref.read(sharedPreferencesProvider);
    return _sharedPrefs.getLocale();
  }

  void changeLocale() async {
    final locale = _determineNewLocale(state);

    await _sharedPrefs.setLocale(locale);
    state = _sharedPrefs.getLocale();

    ref.invalidateSelf();
  }

  Locale _determineNewLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return const Locale('bg');
      case 'bg':
        return const Locale('en');
      default:
        return locale;
    }
  }
}