import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/customdatepickfield.dart';
import 'create_password.dart';
import '../components/otp_screen.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';
import '../components/customtextfield.dart';
import 'package:firebase_core/firebase_core.dart';

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

  String rno = "Empty";

  final myTextFieldController = TextEditingController();
  final myDateFieldController = TextEditingController();

  @override
  void dispose() {
    myTextFieldController.dispose();
    myDateFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            current: 2,
            controller: myTextFieldController,
            fgcolor: fgcolor,
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          //CustomNameField(fgcolor: fgcolor),
          CustomDatePickField(
            controller: myDateFieldController,
            fgcolor: fgcolor,
          ),
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
                print(myTextFieldController.text);
                print(myDateFieldController.text);
                final docUser=FirebaseFirestore.instance.collection('users').doc('user'+user_num.toString());
                user_num+=1;
                final json={
                  'user_id':int.parse(myTextFieldController.text),
                };
                docUser.set(json);
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
