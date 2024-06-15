import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalizationNotifier extends AutoDisposeAsyncNotifier<Locale> {
  Locale currentLocale = const Locale('en');

  @override
  FutureOr<Locale> build() {
    return currentLocale;
  }

  void changeLocale(Locale newLocale) {
    currentLocale = newLocale;

    ref.invalidateSelf();
  }
}