import 'package:flutter/material.dart';
import '../../constants.dart';

class ValidPassExpansionTile extends StatefulWidget {
  ValidPassExpansionTile({
    super.key,
    required this.fgcolor,
    required this.scroll,
  });
  final String bullet = "\u2022 ";
  final Color fgcolor;
  Function(bool) scroll;

  @override
  State<ValidPassExpansionTile> createState() => _ValidPassExpansionTileState();
}

class _ValidPassExpansionTileState extends State<ValidPassExpansionTile> {
  _ValidPassExpansionTileState();

  final String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 13, color: kTextColor.withOpacity(0.7));
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: ListTileTheme(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ExpansionTile(
          textColor: widget.fgcolor,
          collapsedTextColor: widget.fgcolor,
          iconColor: widget.fgcolor,
          collapsedIconColor: widget.fgcolor,
          backgroundColor: kBlack20,
          collapsedBackgroundColor: kBlack20,
          title: const Text(
            'Password Requirements',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
          subtitle: Text(
            'Password must contain ...',
            style: TextStyle(
              color: kTextColor.withOpacity(0.8),
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
