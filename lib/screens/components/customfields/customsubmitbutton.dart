// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';

class CustomSubmitButton extends StatelessWidget {
  final Color bgcolor;
  final Size size;
  final String msg;
  final double? fsize;
  final double height;
  final double width;
  final double borderRadius;
  final Function()? press;
  final bool? isEnabled;
  const CustomSubmitButton({
    super.key,
    required this.size,
    required this.bgcolor,
    required this.msg,
    this.fsize = 18.0,
    this.height = 0.6,
    this.width = 2,
    this.borderRadius = 50,
    required this.press,
    this.isEnabled = true,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      height: 2 * kDefaultPadding * height + fsize! + 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              color: kBlack15,
            )
          ]),
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return kGrey40;
            } else {
              return isDark
                  ? bgcolor.withOpacity(0.8)
                  : bgcolor.withOpacity(0.9);
            }
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return kGrey90;
            } else {
              return kBlack10;
            }
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            return kBlack10;
          }),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return kTextColor.withOpacity(0.3);
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            );
          }),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(
                width: 2,
                color: kGrey30,
              );
            } else {
              return BorderSide(
                width: 2,
                color: bgcolor,
              );
            }
          }),
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.symmetric(
              vertical: kDefaultPadding * height,
              horizontal: kDefaultPadding * width,
            );
          }),
        ),
        child: FittedBox(
          child: Text(
            msg,
            style: TextStyle(
              fontSize: fsize,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
