import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/utility/shared_preferences_service.dart';

class LocalizationNotifier extends AutoDisposeAsyncNotifier<Locale> {
  Locale currentLocale = const Locale('en');

  @override
  FutureOr<Locale> build() {
    return SharedPreferencesService().getLocale();
  }

  void changeLocale(Locale newLocale) {
    currentLocale = newLocale;
    SharedPreferencesService().setLocale(newLocale);

    ref.invalidateSelf();
  }
}