import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/components/popupitem.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/constants.dart';

Future<void> showToggleThemeDialog(BuildContext context) {
  void reponseSnackbar(String theme) {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final snackBar = showCustomSnackBar(
      context,
      "Theme switched to $theme",
      () {},
      icon: Icon(
        Icons.palette_outlined,
        color: isDark ? kTextColor : kLTextColor,
      ),
      borderColor:
          isDark ? kTextColor.withOpacity(0.2) : kLTextColor.withOpacity(0.5),
      duration: const Duration(seconds: 1),
      margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
  return showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: isDark ? kBlack10.withOpacity(0.8) : kGrey30.withOpacity(0.8),
    builder: (BuildContext context) {
      bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
      return SimpleDialog(
        surfaceTintColor: isDark ? kGrey40 : kLBlack15,
        backgroundColor: isDark ? kGrey40 : kLBlack15,
        titleTextStyle:
            AdaptiveTheme.of(context).theme.textTheme.displayMedium!.copyWith(
                  color: isDark ? kTextColor : kLTextColor,
                ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          children: [
            const FittedBox(
              child: Icon(
                Icons.palette_outlined,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Change Theme',
              style:
                  AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ],
        ),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
              if (AdaptiveTheme.of(context).mode != AdaptiveThemeMode.light) {
                AdaptiveTheme.of(context).setLight();
                ScaffoldMessenger.of(context).clearSnackBars();
                Future.delayed(const Duration(milliseconds: 10), () {
                  reponseSnackbar("Light");
                });
              }
            },
            child: PopupItem(
              icon: Icons.light_mode_outlined,
              isSelected:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light,
              title: 'Light Theme',
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
              if (AdaptiveTheme.of(context).mode != AdaptiveThemeMode.dark) {
                AdaptiveTheme.of(context).setDark();
                ScaffoldMessenger.of(context).clearSnackBars();
                Future.delayed(const Duration(milliseconds: 10), () {
                  reponseSnackbar("Dark");
                });
              }
            },
            child: PopupItem(
              icon: Icons.dark_mode_outlined,
              isSelected:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              title: 'Dark Theme',
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
              if (AdaptiveTheme.of(context).mode != AdaptiveThemeMode.system) {
                AdaptiveTheme.of(context).setSystem();
                ScaffoldMessenger.of(context).clearSnackBars();
                Future.delayed(const Duration(milliseconds: 10), () {
                  reponseSnackbar("System Default");
                });
              }
            },
            child: PopupItem(
              icon: Icons.smartphone_outlined,
              isSelected:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system,
              title: 'System Default',
            ),
          ),
        ],
      );
    },
  );
}
