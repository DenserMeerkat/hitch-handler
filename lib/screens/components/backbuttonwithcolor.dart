// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../constants.dart';

class BackButtonWithColor extends StatelessWidget {
  const BackButtonWithColor({
    Key? key,
    required this.shcolor,
    required this.press,
    required this.bgcolor,
    required this.iconbg,
  }) : super(key: key);

  final Color shcolor;
  final Function()? press;
  final Color bgcolor;
  final Color iconbg;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
        decoration: BoxDecoration(
            color: iconbg.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30.0.r),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: shcolor,
              ),
            ],
            border: Border.all(
              width: 2.0.w,
              color: iconbg,
            )),
        child: Material(
          type: MaterialType.transparency,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            splashRadius: 50.0.r,
            splashColor: isDark
                ? kTextColor.withOpacity(0.1)
                : kLTextColor.withOpacity(0.1),
            onPressed: press,
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? kBlack20 : kBlack20,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 5.r,
                  color: bgcolor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ));
  }
}
