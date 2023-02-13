import 'package:flutter/material.dart';
import '../../constants.dart';

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
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bradius),
        color: bgcolor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: shcolor,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
            decoration: BoxDecoration(
                color: fgcolor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(bradius),
                border: Border.all(
                  width: 3.0,
                  color: fgcolor,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.5, 1),
                    color: shcolor,
                  ),
                ]),
            child: Icon(
              icon,
              color: iconcolor,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding * 0.75,
              right: kDefaultPadding * 1.5,
              top: kDefaultPadding / 2,
              bottom: kDefaultPadding / 2,
            ),
            child: FittedBox(
              child: Text(
                title,
                style: TextStyle(
                    color: textcolor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: fsize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
