// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';

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
  }) : super(key: key);

  final double bradius;
  final Color bgcolor;
  final Color shcolor;
  final Color fgcolor;
  final IconData icon;
  final String title;
  final double fsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bradius),
        color: bgcolor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: shcolor,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: fgcolor,
              borderRadius: BorderRadius.circular(bradius),
            ),
            child: Icon(
              icon,
              color: bgcolor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding * 1,
              right: kDefaultPadding * 2,
              top: kDefaultPadding / 2,
              bottom: kDefaultPadding / 2,
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: fgcolor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: fsize),
            ),
          ),
        ],
      ),
    );
  }
}
