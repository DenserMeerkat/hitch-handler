import 'package:flutter/material.dart';
import '../../constants.dart';
import 'customsigninappbar.dart';
import 'forgotform.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.77,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.770,
                width: size.width,
                color: const Color.fromRGBO(30, 30, 30, 1),
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  left: size.width * 0.1,
                  right: size.width * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Text("Enter registered Email ID / Mobile Number."),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ForgotForm(
                      fgcolor: fgcolor,
                      index: 2,
                      title: title,
                      icon: icon,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
