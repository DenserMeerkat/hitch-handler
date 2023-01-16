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
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "HITCH HANDLER",
            style: TextStyle(
              color: kTextColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 2,
              wordSpacing: 5,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: kGrey30,
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
                bgcolor: kBackgroundColor,
                shcolor: kBlack10,
                fgcolor: fgcolor,
                icon: icon,
                title: title,
                fsize: 16,
                press: press,
                iconbg: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
