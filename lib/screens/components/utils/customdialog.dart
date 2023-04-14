// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';

void showAlertDialog(BuildContext context, String title, Widget content,
    List<Widget> actions, IconData icon,
    {Color? fgColor = kPrimaryColor}) {
  final bool isDark =
      AdaptiveTheme.of(context).theme.brightness == Brightness.dark;
  showDialog(
      context: context,
      barrierColor:
          isDark ? kBlack10.withOpacity(0.8) : kGrey30.withOpacity(0.8),
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: title,
          content: content,
          actions: actions,
          icon: icon,
          fgColor: fgColor,
        );
      });
}

Widget buildCancelButton(BuildContext context) {
  return TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(AdaptiveTheme.of(context)
          .theme
          .textTheme
          .bodyLarge!
          .color!
          .withOpacity(0.1)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      'Cancel',
      style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
    ),
  );
}

Widget buildActiveButton(
    BuildContext context, bool submit, String activeText, Function()? onPressed,
    {Color? fgColor = kPrimaryColor}) {
  final bool isDark =
      AdaptiveTheme.of(context).theme.brightness == Brightness.dark;
  return TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(fgColor!.withOpacity(0.1)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    onPressed: submit ? onPressed : null,
    child: Text(
      activeText,
      style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
          color: submit
              ? fgColor
              : isDark
                  ? kTextColor.withOpacity(0.5)
                  : kLTextColor.withOpacity(0.5)),
    ),
  );
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final IconData icon;
  final List<Widget> actions;
  final Color? fgColor;
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    required this.icon,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      title: Row(
        children: [
          FittedBox(
            child: Icon(
              icon,
              color: fgColor ?? kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: fgColor ?? kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: SingleChildScrollView(child: content),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      actions: actions,
      actionsPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
    );
  }
}
