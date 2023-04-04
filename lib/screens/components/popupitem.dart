import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';

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
