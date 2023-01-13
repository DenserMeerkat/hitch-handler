import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/confirmpasswordform.dart';
import '../components/customsigninappbar.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName(homeroute));
        return true;
      },
      child: Theme(
        data: ThemeData(
          accentColor: fgcolor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        ),
        child: Scaffold(
          backgroundColor: kGrey30,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: size.height * 0.18,
            backgroundColor: kBackgroundColor,
            elevation: 0,
            flexibleSpace: CustomSignInAppBar(
                size: size,
                fgcolor: fgcolor,
                title: title,
                icon: icon,
                press: () {
                  Navigator.popUntil(context, ModalRoute.withName(homeroute));
                }),
          ),
          body: ConfirmPasswordBody(
            title: "Create Password",
            subtitle: "Create a password for your account.",
            fgcolor: fgcolor,
            press: () {}, //Todo
          ),
        ),
      ),
    );
  }
}
