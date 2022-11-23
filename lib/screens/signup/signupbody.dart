import 'package:flutter/material.dart';
import '../../constants.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
    required this.formwidget,
    required this.footerwidget,
  });
  final Widget formwidget;
  final Widget footerwidget;
  @override
  Widget build(BuildContext context) {
    return SignupContent(formwidget: formwidget, footerwidget: footerwidget);
  }
}

class SignupContent extends StatelessWidget {
  const SignupContent({
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
      height: size.height * 0.77,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.670,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(30, 30, 30, 1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
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
                  "Create an Account",
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
                  "using  E-mail / Mobile No. / Roll Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextColor.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: size.height * 0.075),
                formwidget,
              ],
            ),
          ),
          SizedBox(height: size.height * 0.1, child: footerwidget)
        ],
      ),
    );
  }
}
