import 'package:flutter/material.dart';
import '../../constants.dart';
import 'backbuttonwithcolor.dart';
import 'labelwithicon.dart';

class UserLoginHeader extends StatelessWidget {
  const UserLoginHeader({
    Key? key,
    this.bradius = 30.0,
    this.bgcolor = kBackgroundColor,
    this.shcolor = kBlack10,
    this.fsize = 16,
    this.herotag,
    required this.press,
    required this.iconbg,
    required this.fgcolor,
    required this.icon,
    required this.title,
    required this.iconcolor,
    required this.textcolor,
  }) : super(key: key);

  final Object? herotag;
  final Color shcolor;
  final Function()? press;
  final Color bgcolor;
  final Color iconbg;
  final Color iconcolor;
  final Color textcolor;
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
      iconcolor: iconcolor,
      textcolor: textcolor,
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
    Size size = MediaQuery.of(context).size;
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
