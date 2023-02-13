import 'package:flutter/material.dart';
import '../../constants.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
    required this.formwidget,
  });
  final Widget formwidget;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // Available screen size
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
        ),
        decoration: BoxDecoration(
          color: isDark ? kGrey30 : kLGrey30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            FittedBox(
              child: Text("Create an Account",
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            FittedBox(
              child: Text(
                "using  E-mail / Mobile No. / Roll Number",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            formwidget,
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
