import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:obs_news/utility/utility_repositories/shared_preferences_repository.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  // Declaring variables
  late ProviderContainer container;

  final Map<String, Object> initialLocale = <String, Object>{SharedPreferencesKeys.locale: 'en'};

  //Setup
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(initialLocale);
    final sharedPrefs = await SharedPreferences.getInstance();

    container = createContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(SharedPreferencesRepository(sharedPrefs))],
    );
  });

  //Tests
  group("Localization Repository Tests", (){
    test("Testing getLocale on initial value.", () {
      expect(container.read(sharedPreferencesProvider).getLocale(), const Locale('en'));
    });

    test("Testing Changing the Locale.", () async {
      await container.read(sharedPreferencesProvider).setLocale(const Locale('bg'));
      expect(container.read(sharedPreferencesProvider).getLocale(), const Locale('bg'));
    });

    test("Testing Changing the Locale multiple times.", () async {
      await container.read(sharedPreferencesProvider).setLocale(const Locale('bg'));
      expect(container.read(sharedPreferencesProvider).getLocale(), const Locale('bg'));

      await container.read(sharedPreferencesProvider).setLocale(const Locale('en'));
      expect(container.read(sharedPreferencesProvider).getLocale(), const Locale('en'));
    });
  });
}