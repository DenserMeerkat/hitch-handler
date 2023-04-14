// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'constants.dart';

class ThemeProvider with ChangeNotifier {
  static String currentTheme = 'system';

  static String getThemeMode() => currentTheme;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeTheme(String theme) {
    currentTheme = theme;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: kLPrimaryColor,
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
      headlineSmall: TextStyle(
        fontSize: 18,
        color: kLTextColor.withOpacity(0.7),
        letterSpacing: 0.6,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: kLPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: kLPrimaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: kLBackgroundColor,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: kPrimaryColor,
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
      headlineSmall: TextStyle(
        fontSize: 18,
        color: kTextColor.withOpacity(0.7),
        letterSpacing: 0.6,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: kPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: kPrimaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: kBackgroundColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
