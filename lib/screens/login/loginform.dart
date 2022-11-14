import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customtextfield.dart';

import '../components/custompasswordfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.fgcolor,
  });
  final Color fgcolor;
  @override
  State<LoginForm> createState() => _LoginFormState(fgcolor);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState(this.fgcolor);
  final Color fgcolor;
  final _formLoginKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formLoginKey,
      child: Column(
        children: [
          CustomTextField(fgcolor: fgcolor),
          SizedBox(
            height: size.height * 0.05,
          ),
          CustomPasswordField(
            fgcolor: fgcolor,
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    return Colors.white.withOpacity(0.08);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    );
                  }),
                  padding: MaterialStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(
                      horizontal: 12,
                    );
                  }),
                ),
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.6,
                    color: fgcolor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          CustomSubmitButton(
            size: size,
            bgcolor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.size,
    required this.bgcolor,
  });
  final Color bgcolor;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              color: Color.fromRGBO(10, 10, 10, 1),
            )
          ]),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return bgcolor.withOpacity(0.8);
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            return const Color.fromRGBO(10, 10, 10, 1);
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            return const Color.fromRGBO(10, 10, 10, 1);
          }),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.3);
            }
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            );
          }),
          side: MaterialStateProperty.resolveWith((states) {
            return BorderSide(
              width: 2,
              color: bgcolor,
            );
          }),
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.symmetric(
              vertical: 15,
              horizontal: size.width * 0.2,
            );
          }),
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
