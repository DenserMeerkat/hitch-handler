import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/components/customdatepickfield.dart';
import '../components/customnamefield.dart';
import '../login/otp_screen.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';
import '../components/customtextfield.dart';
import '../login/otpform.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;

  @override
  State<SignupForm> createState() => _SignupFormState(fgcolor, title, icon);
}

class _SignupFormState extends State<SignupForm> {
  _SignupFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
  final _formSignUpKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formSignUpKey,
      child: Column(
        children: [
          CustomTextField(fgcolor: fgcolor),
          SizedBox(
            height: size.height * 0.025,
          ),
          //CustomNameField(fgcolor: fgcolor),
          CustomDatePickField(fgcolor: fgcolor),
          SizedBox(
            height: size.height * 0.050,
          ),
          CustomSubmitButton(
            size: size,
            bgcolor: kPrimaryColor,
            msg: "Continue",
            fsize: 18,
            width: 0.15,
            press: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              if (_formSignUpKey.currentState!.validate()) {
                _formSignUpKey.currentState!.save();
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return OtpScreen(
                    fgcolor: fgcolor,
                    title: title,
                    icon: icon,
                  );
                }),
              );
            }, //Todo
          ),
        ],
      ),
    );
  }
}
