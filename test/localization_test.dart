import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:obs_news/localization/localization_controller.dart';
import 'package:obs_news/utility/utility_repositories/shared_preferences_repository.dart';

class MockSharedPreferencesService extends Mock implements SharedPreferencesRepository {}

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
  late MockSharedPreferencesService mockSharedPreferencesService;
  final locale = Locale('en');

  setUp(() {
    mockSharedPreferencesService = MockSharedPreferencesService();
  });

  //test('Testing initial value', () {
  //  when(() => SharedPreferencesService().getLocale()).thenReturn(locale);
  //  final container = createContainer(
  //    overrides: [
  //      localizationProvider.overrideWith(() {
  //        return mockSharedPreferencesService.getLocale();
  //      }),
  //    ],
  //  );
//
  //  expect(
  //    container.read(localizationProvider),
  //    equals(Locale('en')),
  //  );
  //});
}