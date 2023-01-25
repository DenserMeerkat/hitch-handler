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

SnackBar showCustomSnackBar(final String text, final String actionLabel,
    final void Function() onPressed,
    {Color backgroundColor = kGrey40,
    Color textColor = kTextColor,
    IconData icon = Icons.error,
    double fsize = 13,
    Color iconColor = kErrorColor,
    Color actionColor = kErrorColor}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    content: Container(
        color: backgroundColor,
        height: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   icon,
            //   color: iconColor,
            //   size: fsize + 5,
            // ),
            // const SizedBox(
            //   width: 15,
            // ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
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
