import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

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

void showConfirmDialog(BuildContext context, Widget dialogCont,
    {double borderRadius = 5,
    bool barrierDismissible = true,
    Color barrierColor = kBlack20}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor.withOpacity(0.8),
      useSafeArea: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
          surfaceTintColor: kGrey30,
          backgroundColor: kBlack20,
          shadowColor: Colors.black,
          child: dialogCont,
        );
      });
}

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

class PopupItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final IconData icon;
  const PopupItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      height: 35.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isSelected
              ? Container(
                  height: 32.h,
                  width: 6,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(2)),
                )
              : const SizedBox(width: 6),
          const SizedBox(width: 10),
          Icon(
            icon,
            color: isDark
                ? kTextColor.withOpacity(0.8)
                : kLTextColor.withOpacity(0.8),
            size: 20.sp,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: isDark
                  ? kTextColor.withOpacity(0.8)
                  : kLTextColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
