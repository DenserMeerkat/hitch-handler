import 'package:flutter/material.dart';
import '../../../constants.dart';

Future<DateTime?> showCustomDatePicker(
    BuildContext context, Color fgcolor, DateTime initialDate) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1940),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: isDark
            ? ThemeData.dark().copyWith(
                dialogBackgroundColor: kGrey30,
                colorScheme: ColorScheme.dark(
                  primary: fgcolor,
                  onSurface: kTextColor,
                ),
                buttonTheme: const ButtonThemeData(
                  colorScheme: ColorScheme.dark(),
                ),
              )
            : ThemeData.light().copyWith(
                dialogBackgroundColor: kLGrey30,
                colorScheme: const ColorScheme.light(
                  primary: kBlack20,
                  onSurface: kLTextColor,
                ),
                buttonTheme: const ButtonThemeData(
                  colorScheme: ColorScheme.light(),
                ),
              ),
        child: child!,
      );
    },
  );
}

Future<TimeOfDay?> selectTime(
    BuildContext context, Color fgcolor, TimeOfDay initialTime) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: fgcolor,
            onSurface: kTextColor,
          ),
          buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.dark(),
          ),
        ),
        child: child!,
      );
    },
  );
}
