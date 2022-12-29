import 'package:flutter/material.dart';
import '../../constants.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.formwidget,
    required this.footerwidget,
  });
  final Widget formwidget;
  final Widget footerwidget;
  @override
  Widget build(BuildContext context) {
    return LoginContent(formwidget: formwidget, footerwidget: footerwidget);
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
    required this.formwidget,
    required this.footerwidget,
  });
  final Widget formwidget;
  final Widget footerwidget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return SizedBox(
      height: size.height * 0.772,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.67,
            width: size.height * 0.95,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(30, 30, 30, 1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0.5),
                  blurRadius: 1,
                  color: Colors.black,
                ),
              ],
            ),
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
            child: footerwidget,
          )
        ],
      ),
    );
  }
}
