import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

Future<DateTime?> showCustomDatePicker(
    BuildContext context, Color fgcolor, DateTime initialDate) {
  final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1940),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 5.w),
        child: Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  useMaterial3: true,
                  dialogBackgroundColor: kBlack20,
                  datePickerTheme: const DatePickerThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    headerBackgroundColor: kBlack20,
                    backgroundColor: kGrey30,
                    surfaceTintColor: kGrey70,
                  ),
                  colorScheme: ColorScheme.dark(
                    primary: fgcolor,
                    onSurface: kTextColor,
                  ),
                  buttonTheme: const ButtonThemeData(
                    colorScheme: ColorScheme.dark(),
                  ),
                )
              : ThemeData.light().copyWith(
                  useMaterial3: true,
                  dialogBackgroundColor: kGrey30,
                  datePickerTheme: const DatePickerThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    headerBackgroundColor: kGrey30,
                    headerForegroundColor: kTextColor,
                    backgroundColor: kLBlack20,
                    surfaceTintColor: kLBlack20,
                  ),
                  colorScheme: ColorScheme.light(
                    primary: fgcolor,
                    onSurface: kLTextColor,
                  ),
                  buttonTheme: const ButtonThemeData(
                    colorScheme: ColorScheme.dark(),
                  ),
                ),
          child: child!,
        ),
      );
    },
  );
}

Future<TimeOfDay?> selectTime(
    BuildContext context, Color fgcolor, TimeOfDay initialTime) {
  final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: isDark
            ? ThemeData.dark().copyWith(
                //useMaterial3: true,
                textTheme: AdaptiveTheme.of(context).theme.textTheme,
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
                //useMaterial3: true,
                colorScheme: ColorScheme.light(
                  primary: fgcolor,
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
