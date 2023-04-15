// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/popupmenu.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final IconData leadingIcon;
  final String leadingTooltip;
  final Function()? leadingAction;
  final bool showActions;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.leadingIcon = Icons.arrow_back_rounded,
    this.leadingTooltip = "Back",
    this.leadingAction,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 80.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 38.r,
                    width: 38.r,
                    margin: const EdgeInsets.only(left: 24.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isDark
                            ? kPrimaryColor.withOpacity(0.8)
                            : kLPrimaryColor.withOpacity(0.9),
                        border: Border.all(
                            color: isDark ? kPrimaryColor : kLPrimaryColor),
                        boxShadow: const [
                          BoxShadow(
                            color: kBlack20,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: IconButton(
                      splashColor: splash(isDark),
                      focusColor: splash(isDark),
                      highlightColor: splash(isDark),
                      hoverColor: splash(isDark),
                      splashRadius: 20.0,
                      icon: Icon(
                        leadingIcon,
                        color: kLTextColor,
                        size: 20,
                        shadows: [
                          Shadow(
                              color: kGrey40.withOpacity(0.3),
                              offset: const Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                      onPressed: leadingAction,
                      tooltip: leadingTooltip,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: showActions ? const PopupMenu() : Container()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 8, 30, 8).r,
                    decoration: BoxDecoration(
                        color: isDark ? kBackgroundColor : kGrey50,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: isDark ? kBlack10 : kGrey30,
                          )
                        ]),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: kTextColor,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          title,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 1.5,
            color: isDark ? kGrey40 : kLGrey40,
          )
        ],
      ),
    );
  }
}
