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
    switch(currentLocale.languageCode) {
      case 'en':
        newLocale = const Locale('bg');
        break;
      case 'bg':
        newLocale = const Locale('en');
        break;
      default:
        newLocale = const Locale('en');
        break;
    }
    currentLocale = newLocale;
    SharedPreferencesService().setLocale(newLocale);

    ref.invalidateSelf();
  }
}