import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
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
      content: content,
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      actions: actions,
      actionsPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
    );
  }
}

SnackBar showCustomSnackBar(BuildContext snackbarContext, final String text,
    final void Function() onPressed,
    {Icon? icon,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    String? actionLabel,
    Duration? duration,
    EdgeInsetsGeometry? margin,
    double fsize = 13,
    Color iconColor = kErrorColor,
    Color actionColor = kErrorColor}) {
  bool isDark =
      AdaptiveTheme.of(snackbarContext).theme.brightness == Brightness.dark;
  Size size = MediaQuery.of(snackbarContext).size;
  return SnackBar(
    duration: duration ?? const Duration(seconds: 3),
    backgroundColor: backgroundColor ?? (isDark ? kGrey40 : kLBackgroundColor),
    behavior: SnackBarBehavior.floating,
    margin: margin ??
        EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 10),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor ?? Colors.transparent)),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ?? const SizedBox(),
        icon != null ? const SizedBox(width: 10) : const SizedBox(),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: textColor ?? (isDark ? kTextColor : kLTextColor),
              fontSize: fsize,
            ),
          ),
        ),
      ],
    ),
    action: actionLabel != null
        ? SnackBarAction(
            label: actionLabel,
            textColor: actionColor,
            onPressed: onPressed,
          )
        : null,
  );
}
