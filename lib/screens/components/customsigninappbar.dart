import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'userloginheader.dart';

class CustomSignInAppBar extends StatelessWidget {
  const CustomSignInAppBar({
    super.key,
    required this.size,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.press,
    this.herotag,
  });
  final Object? herotag;
  final Size size;
  final Color fgcolor;
  final String title;
  final IconData icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      //margin: const EdgeInsets.only(top: 10),
      color: isDark ? kBackgroundColor : kLBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "HITCH HANDLER",
            style: TextStyle(
              color: isDark
                  ? kTextColor.withOpacity(0.7)
                  : kLTextColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 2,
              wordSpacing: 5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: isDark ? kGrey30 : kLGrey30,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -5),
                  color: fgcolor.withOpacity(0.9),
                ),
              ],
            ),
            child: SizedBox(
              height: 80,
              child: UserLoginHeader(
                herotag: herotag,
                bradius: 30.0,
                bgcolor: isDark ? kBackgroundColor : kLBackgroundColor,
                shcolor: isDark ? kBlack10 : kGrey90,
                fgcolor: fgcolor,
                icon: icon,
                title: title,
                fsize: 16,
                press: press,
                iconbg: isDark ? kPrimaryColor : kLPrimaryColor,
                iconcolor: isDark ? kBlack20 : kBlack20,
                textcolor: isDark ? fgcolor : kBlack20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
