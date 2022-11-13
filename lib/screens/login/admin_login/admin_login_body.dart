// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../constants.dart';
import '../../components/loginsignupfooter.dart';
import '../../components/userloginheader.dart';

class AdminLoginBody extends StatelessWidget {
  AdminLoginBody({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.formwidget,
  });
  final Color fgcolor;
  final String title;
  Widget formwidget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size

    return StickyHeader(
        header: Container(
          height: size.height * 0.24,
          color: kBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.only(top: size.height * 0.03),
                  child: Text(
                    "HITCH HANDLER",
                    style: TextStyle(
                      color: kTextColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      wordSpacing: 5,
                      letterSpacing: 2,
                    ),
                  )),
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
                    size: size,
                    bradius: 30.0,
                    bgcolor: kBackgroundColor,
                    shcolor: const Color.fromRGBO(10, 10, 10, 1),
                    fgcolor: fgcolor,
                    icon: Icons.school,
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
        ),
        content: AdminLoginContent(
          formwidget: formwidget,
        ));
  }
}

class AdminLoginContent extends StatelessWidget {
  AdminLoginContent({
    super.key,
    required this.formwidget,
  });
  Widget formwidget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return SizedBox(
      height: size.height * 0.76,
      child: Column(
        children: [
          Container(
            height: size.height * 0.660,
            color: const Color.fromRGBO(30, 30, 30, 1),
            padding: EdgeInsets.only(
              top: 0,
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "Sign In to continue to app.",
                  style: TextStyle(
                    color: kTextColor.withOpacity(0.7),
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: size.height * 0.075),
                formwidget,
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
            child: LoginSignUpFooter(
              size: size,
              msg: "Contact support to register as an Authority.",
              btntext: "Support",
              fsize: 15,
              press: () {}, //Todo
            ),
          )
        ],
      ),
    );
  }
}
