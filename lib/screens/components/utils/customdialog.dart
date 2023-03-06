import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

Future<void> showToggleThemeDialog(BuildContext context) {
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
        title: Text(
          'Change Theme',
          style: TextStyle(
            fontSize: 20.sp,
          ),
        ),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
              AdaptiveTheme.of(context).setLight();
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
              AdaptiveTheme.of(context).setDark();
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
              AdaptiveTheme.of(context).setSystem();
            },
            child: PopupItem(
              icon: Icons.smartphone_outlined,
              isSelected:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system,
              title: 'System Theme',
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

SnackBar showCustomSnackBar(BuildContext context, final String text,
    final String actionLabel, final void Function() onPressed,
    {Color? backgroundColor,
    Color? textColor,
    IconData icon = Icons.error,
    double fsize = 13,
    Color iconColor = kErrorColor,
    Color actionColor = kErrorColor}) {
  bool isDark = MediaQueryData.fromView(WidgetsBinding.instance.window)
          .platformBrightness ==
      Brightness.dark;
  Size size = MediaQuery.of(context).size;
  return SnackBar(
    backgroundColor: backgroundColor ?? (isDark ? kGrey40 : kGrey40),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 10),
    content: Container(
        color: backgroundColor ?? (isDark ? kGrey40 : kGrey40),
        height: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor ?? (isDark ? kTextColor : kTextColor),
                fontSize: fsize,
              ),
            ),
          ],
        )),
    action: SnackBarAction(
      label: actionLabel,
      textColor: actionColor,
      onPressed: onPressed,
    ),
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
          // SizedBox(
          //   width: 20.w,
          // ),
        ],
      ),
    );
  }
}
