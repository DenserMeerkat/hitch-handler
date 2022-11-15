import 'package:flutter/material.dart';
import 'backbuttonwithcolor.dart';
import 'labelwithicon.dart';

class UserLoginHeader extends StatelessWidget {
  const UserLoginHeader({
    Key? key,
    required this.size,
    required this.bradius,
    required this.bgcolor,
    required this.shcolor,
    required this.fgcolor,
    required this.icon,
    required this.title,
    required this.fsize,
    required this.press,
    required this.iconbg,
    this.herotag,
  }) : super(key: key);

  final Size size;
  final Object? herotag;
  final Color shcolor;
  final Function()? press;
  final Color bgcolor;
  final Color iconbg;
  final double bradius;
  final Color fgcolor;
  final IconData icon;
  final String title;
  final double fsize;

  Widget labelwithicon() {
    Widget labelicon = LabelWithIcon(
      bradius: bradius,
      bgcolor: bgcolor,
      shcolor: shcolor,
      fgcolor: fgcolor,
      icon: icon,
      title: title,
      fsize: fsize,
    );
    if (herotag != null) {
      return Hero(
        tag: herotag!,
        child: Material(type: MaterialType.transparency, child: labelicon),
      );
    } else {
      return labelicon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.075,
        right: size.width * 0.075,
      ),
      child: Row(
        children: [
          labelwithicon(),
          const Spacer(),
          BackButtonWithColor(
            shcolor: shcolor,
            press: press,
            bgcolor: bgcolor,
            iconbg: iconbg,
          ),
        ],
      ),
    );
  }
}
