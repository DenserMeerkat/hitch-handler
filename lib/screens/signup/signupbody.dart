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
    Size size = MediaQuery.of(context).size; // Available screen size
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: kStudentColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          decoration: const BoxDecoration(
            color: kGrey30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              const FittedBox(
                child: Text(
                  "Create an Account",
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
                  "using  E-mail / Mobile No. / Roll Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextColor.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
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
      ),
    );
  }
}
