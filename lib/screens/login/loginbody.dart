import 'package:flutter/material.dart';
import '../../constants.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.formwidget,
  });
  final Widget formwidget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: kGrey30,
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.1,
          right: size.width * 0.1,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            const FittedBox(
              child: Text(
                "Welcome Back!",
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            FittedBox(
              child: Text(
                "Sign In to continue to app.",
                style: TextStyle(
                  color: kTextColor.withOpacity(0.7),
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.075),
            formwidget,
          ],
        ),
      ),
    );
  }
}
