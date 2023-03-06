import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/components/customfields/customelevatedbutton.dart';
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
    Widget labelicon =
        // CustomElevatedButtonWithIcon(
        //   fgcolor: fgcolor,
        //   iconcolor: iconcolor,
        //   textcolor: textcolor,
        //   shcolor: shcolor,
        //   title: title,
        //   press: () {},
        //   icon: icon,
        //   isButton: false,
        // );
        LabelWithIcon(
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
        child: Material(
          type: MaterialType.transparency,
          child: labelicon,
        ),
      );
    } else {
      return labelicon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelwithicon(),
          SizedBox(width: 10.w),
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
