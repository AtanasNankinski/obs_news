import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/utility/utility_repositories/shared_preferences_repository.dart';

class LocalizationController extends AutoDisposeAsyncNotifier<Locale> {

  @override
  FutureOr<Locale> build() {
    final sharedPrefs = ref.read(sharedPreferencesProvider);
    return sharedPrefs.getLocale();
  }

  void changeLocale() async {
    try {
      state = const AsyncValue.loading();
      final sharedPrefs = ref.read(sharedPreferencesProvider);
      final locale = _determineNewLocale(state.value!);

      await sharedPrefs.setLocale(locale);
      state = AsyncValue.data(sharedPrefs.getLocale());
    } catch(e) {
      state = AsyncValue.error(e, StackTrace.current);
    }

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

final localizationProvider = AsyncNotifierProvider.autoDispose<LocalizationController ,Locale>(LocalizationController.new);