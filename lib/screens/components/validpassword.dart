import 'package:flutter/material.dart';
import '../../constants.dart';

class ValidPassExpansionTile extends StatefulWidget {
  ValidPassExpansionTile({
    super.key,
    required this.fgcolor,
    required this.scroll,
    this.textStyle = const TextStyle(fontSize: 13, color: kGrey90),
  });
  final String bullet = "\u2022 ";
  final Color fgcolor;
  final TextStyle textStyle;
  Function(bool) scroll;

  @override
  State<ValidPassExpansionTile> createState() => _ValidPassExpansionTileState();
}

class _ValidPassExpansionTileState extends State<ValidPassExpansionTile> {
  _ValidPassExpansionTileState();

  final String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    TextStyle textStyle = TextStyle(
        fontSize: 13,
        color: isDark ? kTextColor.withOpacity(0.7) : kLTextColor);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: ListTileTheme(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ExpansionTile(
          textColor: isDark ? widget.fgcolor : kLTextColor,
          collapsedTextColor: isDark ? widget.fgcolor : kLTextColor,
          iconColor: isDark ? widget.fgcolor : kLTextColor,
          collapsedIconColor: isDark ? widget.fgcolor : kLTextColor,
          backgroundColor: isDark ? kBlack20 : kLGrey40,
          collapsedBackgroundColor: isDark ? kBlack20 : kLGrey40,
          title: Text(
            'Password Requirements',
            style: TextStyle(
                fontSize: 17.0,
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
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "$bullet Atleast one Lowercase letter",
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "$bullet Atleast one Digit",
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "$bullet Atleast one Special character",
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "$bullet Minimum 8 characters",
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 5.0,
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
        ),
      ),
    );
  }
}
