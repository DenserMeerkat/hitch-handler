import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../components/userloginheader.dart';

class CustomSignInAppBar extends StatelessWidget {
  const CustomSignInAppBar({
    super.key,
    required this.size,
    required this.fgcolor,
    required this.title,
    required this.icon,
    this.herotag,
  });
  final Object? herotag;
  final Size size;
  final Color fgcolor;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
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
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            padding: EdgeInsets.only(top: size.height * 0.015),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(30, 30, 30, 1),
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
              height: size.height * 0.1,
              child: UserLoginHeader(
                herotag: herotag,
                size: size,
                bradius: 30.0,
                bgcolor: kBackgroundColor,
                shcolor: const Color.fromRGBO(10, 10, 10, 1),
                fgcolor: fgcolor,
                icon: icon,
                title: title,
                fsize: 16,
                press: () {
                  Navigator.pop(context);
                },
                iconbg: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
