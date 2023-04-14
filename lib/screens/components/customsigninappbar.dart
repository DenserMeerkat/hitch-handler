// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customappbar.dart';

class CustomSignInAppBar extends StatelessWidget {
  const CustomSignInAppBar({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    this.leadingIcon = Icons.arrow_back_rounded,
    this.leadingToolTip = "Back",
    required this.leadingAction,
    this.showActions = true,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final IconData leadingIcon;
  final String leadingToolTip;
  final Function() leadingAction;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? kBackgroundColor : kLBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            appName.toUpperCase(),
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
            height: 75.h,
            padding: EdgeInsets.only(top: 17.h),
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
            child: CustomAppBar(
              title: title,
              icon: icon,
              leadingIcon: leadingIcon,
              leadingAction: leadingAction,
              leadingTooltip: leadingToolTip,
              showActions: showActions,
            ),
          ),
        ],
      ),
    );
  }
}
