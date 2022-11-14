import 'package:flutter/material.dart';
import 'loginform.dart';
import '../../constants.dart';
import '../components/loginsignupfooter.dart';
import 'customsigninappbar.dart';
import 'loginbody.dart';

class AuthorityLoginScreen extends StatelessWidget {
  const AuthorityLoginScreen({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    this.herotag,
  });
  final Object? herotag;
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
          child: LoginBody(
        title: title,
        fgcolor: fgcolor,
        formwidget: LoginForm(
          fgcolor: fgcolor,
        ),
        footerwidget: LoginSignUpFooter(
          size: size,
          msg: "Contact Support to register as an Admin.",
          btntext: "Support",
          fsize: 15,
          press: () {}, //Todo
        ),
      )),
    );
  }
}
