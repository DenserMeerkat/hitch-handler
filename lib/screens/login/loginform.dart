import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';
import '../components/customtextfield.dart';
import 'forgot_screen.dart';
import '../components/custompasswordfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  State<LoginForm> createState() => _LoginFormState(fgcolor, title, icon);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ForgotPage(
                        fgcolor: fgcolor,
                        title: title,
                        icon: icon,
                      );
                    }),
                  );
                },
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
            msg: "Continue",
            fsize: 18,
            width: 0.15,
            press: () {}, //Todo
          ),
        ],
      ),
    );
  }
}
