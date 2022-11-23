import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customsigninappbar.dart';
import '../components/loginsignupfooter.dart';
import 'signupbody.dart';
import 'signupform.dart';

class StudentSignupScreen extends StatelessWidget {
  const StudentSignupScreen({
    super.key,
    required this.herotag,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Object herotag;
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.18,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        flexibleSpace: CustomSignInAppBar(
          herotag: herotag,
          size: size,
          fgcolor: fgcolor,
          title: title,
          icon: icon,
        ),
      ),
      body: SingleChildScrollView(
          child: SignupBody(
        formwidget: SignupForm(
          fgcolor: fgcolor,
          title: title,
          icon: icon,
        ),
        footerwidget: LoginSignUpFooter(
          size: size,
          msg: "Already have an account ?",
          btntext: "Login",
          fsize: 16,
          press: () {
            Navigator.of(context).pop(context);
          }, //Todo
        ),
      )),
    );
  }
}
