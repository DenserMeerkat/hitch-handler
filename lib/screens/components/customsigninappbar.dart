import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';
import 'userloginheader.dart';

class CustomSignInAppBar extends StatelessWidget {
  const CustomSignInAppBar({
    super.key,
    required this.size,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.press,
    this.herotag,
  });
  final Object? herotag;
  final Size size;
  final Color fgcolor;
  final String title;
  final IconData icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? kBackgroundColor : kLBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "HITCH HANDLER",
            style: TextStyle(
              color: isDark
                  ? kTextColor.withOpacity(0.7)
                  : kLTextColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
              letterSpacing: 2.sp,
              wordSpacing: 5.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.only(top: 5.h),
            decoration: BoxDecoration(
              color: isDark ? kGrey30 : kLGrey30,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0.r),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.w, -5.h),
                  color: fgcolor.withOpacity(0.9),
                ),
              ],
            ),
            child: SizedBox(
              height: 80.h,
              child: UserLoginHeader(
                herotag: herotag,
                bradius: 30.0,
                bgcolor: isDark ? kBackgroundColor : kLBackgroundColor,
                shcolor: isDark ? kBlack10 : kLGrey70,
                fgcolor: fgcolor,
                icon: icon,
                title: title,
                fsize: 15,
                press: press,
                iconbg: isDark ? kPrimaryColor : kLPrimaryColor,
                iconcolor: isDark ? kBlack20 : kBlack20,
                textcolor: isDark ? fgcolor : kBlack20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
