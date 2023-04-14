// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelWithIcon extends StatelessWidget {
  const LabelWithIcon({
    Key? key,
    required this.bradius,
    required this.bgcolor,
    required this.shcolor,
    required this.fgcolor,
    required this.icon,
    required this.title,
    required this.fsize,
    required this.iconcolor,
    required this.textcolor,
  }) : super(key: key);

  final double bradius;
  final Color bgcolor;
  final Color shcolor;
  final Color fgcolor;
  final Color iconcolor;
  final Color textcolor;
  final IconData icon;
  final String title;
  final double fsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 40.h, maxWidth: 300.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bradius.r),
        color: bgcolor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.w, 2.h),
            color: shcolor,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70.w,
            height: 40.h,
            decoration: BoxDecoration(
                color: fgcolor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(bradius.r),
                border: Border.all(
                  width: 3.0,
                  color: fgcolor,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.5.w, 1.h),
                    color: shcolor,
                  ),
                ]),
            child: Icon(
              icon,
              color: iconcolor,
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 120.w),
            padding: EdgeInsets.only(
              left: 14.w,
              right: 24.w,
              top: 10.h,
              bottom: 10.h,
            ),
            child: Center(
              child: AutoSizeText(
                title,
                maxLines: 1,
                style: TextStyle(
                  color: textcolor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: fsize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
