// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';

class BackButtonWithColor extends StatelessWidget {
  const BackButtonWithColor({
    Key? key,
    required this.shcolor,
    required this.press,
    required this.bgcolor,
    required this.iconbg,
  }) : super(key: key);

  final Color shcolor;
  final Function()? press;
  final Color bgcolor;
  final Color iconbg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: iconbg,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: shcolor,
          ),
        ],
      ),
      child: IconButton(
        onPressed: press,
        icon: Icon(
          Icons.arrow_back,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 5,
              color: bgcolor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
