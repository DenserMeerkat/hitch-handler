import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class Styles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: kLBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        color: kLTextColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 35,
      ),
      titleSmall: TextStyle(
        color: kLTextColor.withOpacity(0.7),
        letterSpacing: 0.6,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: kLPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: kPrimaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 35,
      ),
      titleSmall: TextStyle(
        color: kTextColor.withOpacity(0.7),
        letterSpacing: 0.6,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: kPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: kLPrimaryColor,
    ),
  );

  static void darkStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: kBackgroundColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: kBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static void lightStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: kLBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kLBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}

//textTheme:Theme.of(context).textTheme.apply(bodyColor: kTextColor),

