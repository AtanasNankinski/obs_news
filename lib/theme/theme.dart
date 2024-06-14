import 'package:flutter/material.dart';

import 'package:obs_news/theme/colors.dart';

ThemeData mainTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryColor,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonThemeData,
  textTheme: textTheme
);

AppBarTheme appBarTheme = const AppBarTheme(
  color: appBarColor,
);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(100, 40),
    backgroundColor: colorButtonMain,
    foregroundColor: colorButtonText,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(30)
        )
    ),
    textStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    disabledBackgroundColor: colorButtonDisabled,
  ),
);

TextTheme textTheme = TextTheme(
  bodyLarge: const TextStyle(
    color: mainTextColor,
    fontSize: 20
  ),
  bodyMedium: const TextStyle(
    color: mainTextColor,
    fontSize: 16
  ),
  bodySmall: const TextStyle(
    color: mainTextColor,
    fontSize: 14
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Roboto',
    color: secondaryTextColor,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Roboto',
    color: secondaryTextColor,
    fontSize: 42,
    fontWeight: FontWeight.w500,
  ),
);