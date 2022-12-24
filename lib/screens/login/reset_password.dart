import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customsigninappbar.dart';
import '../components/confirmpasswordform.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
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
        ),
      ),
      body: ConfirmPasswordBody(
        title: "Reset Password",
        subtitle: "Create a new password for your account.",
        fgcolor: fgcolor,
        press: () {}, //Todo
      ),
    );
  }
}
