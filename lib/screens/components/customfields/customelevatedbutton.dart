import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    Key? key,
    this.bgcolor = kBackgroundColor,
    required this.fgcolor,
    required this.iconcolor,
    required this.textcolor,
    this.shcolor = kBlack20,
    this.bradius = 50,
    this.fsize = 14,
    required this.title,
    required this.press,
    required this.icon,
    this.height = kDefaultPadding * 2,
    this.width = kDefaultPadding * 12,
    this.isButton = true,
  }) : super(key: key);
  final Color bgcolor;
  final Color fgcolor;
  final Color shcolor;
  final Color iconcolor;
  final Color textcolor;
  final double bradius;
  final double fsize;
  final String title;
  final Function()? press;
  final IconData icon;
  final double height;
  final double width;
  final bool isButton;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(bradius.r),
        boxShadow: [
          BoxShadow(
            color: shcolor,
            offset: const Offset(1, 2),
          )
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 40.h,
          maxWidth: size.width < 360 ? 240.w : 250,
        ),
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minWidth: 75.w,
                    maxWidth: 75.w,
                  ),
                  height: height.h,
                  width: 70.w,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: fgcolor.withOpacity(0.9),
                    border: Border.all(
                      width: 3.0.w,
                      color: fgcolor,
                    ),
                    borderRadius: BorderRadius.circular(bradius.r),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1.w, 0.h),
                        color: shcolor,
                      )
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Icon(
                          icon,
                          color: iconcolor,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2.sp,
                      fontSize: fsize.sp,
                      color: textcolor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Theme.of(context).brightness == Brightness.dark
                    ? isButton
                        ? kTextColor.withOpacity(0.1)
                        : Colors.transparent
                    : isButton
                        ? kLTextColor.withOpacity(0.1)
                        : Colors.transparent,
                focusColor: Theme.of(context).brightness == Brightness.dark
                    ? isButton
                        ? kTextColor.withOpacity(0.1)
                        : Colors.transparent
                    : isButton
                        ? kLTextColor.withOpacity(0.1)
                        : Colors.transparent,
                hoverColor: Theme.of(context).brightness == Brightness.dark
                    ? isButton
                        ? kTextColor.withOpacity(0.1)
                        : Colors.transparent
                    : isButton
                        ? kLTextColor.withOpacity(0.1)
                        : Colors.transparent,
                highlightColor: Theme.of(context).brightness == Brightness.dark
                    ? isButton
                        ? kTextColor.withOpacity(0.1)
                        : Colors.transparent
                    : isButton
                        ? kLTextColor.withOpacity(0.1)
                        : Colors.transparent,
                onTap: press,
                borderRadius: BorderRadius.circular(bradius.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonWithIcon extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final IconData icon;
  final Color activeColor;
  final Color borderColor;
  final double borderRadius;
  final double leftPad;
  final double rightPad;
  const ElevatedButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.activeColor,
    this.rightPad = 8.0,
    this.leftPad = 8.0,
    this.borderColor = Colors.transparent,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18.sp,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kGrey30;
          }
          return activeColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kTextColor.withOpacity(0.5);
          }
          return kBlack10;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            side: BorderSide(color: borderColor),
          ),
        ),
        padding: MaterialStateProperty.resolveWith((states) {
          return EdgeInsets.only(
            top: 5.h,
            bottom: 5.h,
            left: 10.w,
            right: 12.w,
          );
        }),
      ),
      label: Padding(
        padding: EdgeInsets.only(left: leftPad.w, right: rightPad.w),
        child: FittedBox(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonWithoutIcon extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color activeColor;
  final Color borderColor;
  final double borderRadius;
  final double horizontalPad;
  const ElevatedButtonWithoutIcon({
    super.key,
    required this.onPressed,
    required this.label,
    required this.activeColor,
    this.horizontalPad = 8.0,
    this.borderColor = Colors.transparent,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kGrey30;
          }
          return activeColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kTextColor.withOpacity(0.5);
          }
          return kBlack10;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 12,
          );
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
