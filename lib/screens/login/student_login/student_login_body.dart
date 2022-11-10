// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/loginsignupfooter.dart';
import 'package:hitch_handler/screens/components/userloginheader.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height - 92,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(
            top: kDefaultPadding / 2,
          ),
          height: size.height * 0.79,
          decoration: BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -5),
                color: kStudentColor.withOpacity(0.9),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: UserLoginHeader(
                  size: size,
                  bradius: 30.0,
                  bgcolor: kBackgroundColor,
                  shcolor: Color.fromRGBO(10, 10, 10, 1),
                  fgcolor: kStudentColor,
                  icon: Icons.school,
                  title: "Student",
                  fsize: 18,
                  press: () {},
                  iconbg: kPrimaryColor,
                ),
              ),
              Expanded(
                flex: 14,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: LoginSignUpFooter(
                  size: size,
                  msg: "Don't have an account ?",
                  btntext: "Sign Up",
                  fsize: 16,
                  press: () {}, //Todo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
