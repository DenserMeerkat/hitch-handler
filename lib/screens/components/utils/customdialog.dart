import 'package:flutter/material.dart';
import '../../../constants.dart';

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
  bool isDark = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
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
