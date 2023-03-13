import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class ValidPassExpansionTile extends StatefulWidget {
  const ValidPassExpansionTile({
    super.key,
    required this.fgcolor,
    required this.scroll,
    this.textStyle = const TextStyle(fontSize: 13, color: kGrey90),
    this.bgColor,
  });
  final String bullet = "\u2022 ";
  final Color fgcolor;
  final Color? bgColor;
  final TextStyle textStyle;
  final Function(bool) scroll;

  @override
  State<ValidPassExpansionTile> createState() => _ValidPassExpansionTileState();
}

class _ValidPassExpansionTileState extends State<ValidPassExpansionTile> {
  _ValidPassExpansionTileState();

  final String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    TextStyle textStyle = TextStyle(
        fontSize: 13.sp,
        color: isDark ? kTextColor.withOpacity(0.7) : kLTextColor);
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      textColor: isDark ? widget.fgcolor : kLTextColor,
      collapsedTextColor: isDark ? widget.fgcolor : kLTextColor,
      iconColor: isDark ? widget.fgcolor : kLTextColor,
      collapsedIconColor: isDark ? widget.fgcolor : kLTextColor,
      backgroundColor:
          widget.bgColor ?? (isDark ? kBackgroundColor : kLBackgroundColor),
      collapsedBackgroundColor:
          widget.bgColor ?? (isDark ? kBackgroundColor : kLBackgroundColor),
      title: Text(
        'Password Requirements',
        style: TextStyle(
            fontSize: 17.0.sp,
            fontWeight: isDark ? FontWeight.w500 : FontWeight.bold),
      ),
      subtitle: Text(
        'Password must contain ...',
        style: TextStyle(
          color: isDark ? kTextColor.withOpacity(0.8) : kLTextColor,
          letterSpacing: 1,
        ),
      ),
      children: <Widget>[
        ListTile(
          dense: true,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$bullet Atleast one Uppercase letter",
                style: textStyle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "$bullet Atleast one Lowercase letter",
                style: textStyle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "$bullet Atleast one Digit",
                style: textStyle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "$bullet Atleast one Special character",
                style: textStyle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "$bullet Minimum 8 characters",
                style: textStyle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
            ],
          ),
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          widget.scroll(expanded);
        });
      },
    );
  }
}
