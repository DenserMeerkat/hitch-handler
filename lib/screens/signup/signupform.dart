import 'package:flutter/material.dart';
import '../components/customdatepickfield.dart';
import 'create_password.dart';
import '../components/otp_screen.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';
import '../components/customtextfield.dart';

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
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              current: 2,
              onSubmit: (value) {}, //Todo
              fgcolor: fgcolor),
          SizedBox(
            height: size.height * 0.015,
          ),
          //CustomNameField(fgcolor: fgcolor),
          CustomDatePickField(
              onSubmit: (value) {}, //Todo
              fgcolor: fgcolor),
          SizedBox(
            height: size.height * 0.030,
          ),
          CustomSubmitButton(
            size: size,
            bgcolor: kPrimaryColor,
            msg: "Continue",
            fsize: 18,
            width: 0.15,
            press: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print("____SignUp Form Valid!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return OtpScreen(
                      fgcolor: fgcolor,
                      title: title,
                      icon: icon,
                      nextPage: CreatePasswordPage(
                        fgcolor: fgcolor,
                        title: title,
                        icon: icon,
                      ),
                    );
                  }),
                );
              } else {
                print("____SignUp Form Error!");
              }
            }, //Todo_Navigation
          ),
        ],
      ),
    );
  }
}
