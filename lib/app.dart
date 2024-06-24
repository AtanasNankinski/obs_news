import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:obs_news/localization/localization_controller.dart';
import 'package:obs_news/utility/config_reader.dart';
import 'package:obs_news/navigation/routing.dart';
import 'package:obs_news/navigation/routing_constants.dart';
import 'package:obs_news/theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Locale currentLocale = ref.watch(localizationControllerProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: ConfigReader.isDebug(),
      onGenerateRoute: Routing.generateRoute,
      initialRoute: RoutingConst.splashRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale,
      theme: mainTheme,
    );
  }
}