import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/components/popupitem.dart';
import 'package:hitch_handler/constants.dart';

Future<void> showToggleThemeDialog(BuildContext context) {
  void reponseSnackbar(String theme) {
    final scaffoldContext = ScaffoldMessenger.of(context);
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final snackBar = SnackBar(
      content: Text(
        "Theme switched to $theme",
        style: TextStyle(color: isDark ? kTextColor : kLTextColor),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isDark ? kGrey40 : kLBlack10,
    );
    scaffoldContext.showSnackBar(snackBar);
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
