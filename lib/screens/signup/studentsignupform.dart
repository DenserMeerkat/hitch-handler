import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../args_class.dart';
import '../components/customfields/customdatepickfield.dart';
import 'create_password.dart';
import '../components/otp_screen.dart';
import '../../constants.dart';
import '../components/customfields/customsubmitbutton.dart';
import '../components/customfields/custommultifield.dart';

class StudentSignupForm extends StatefulWidget {
  const StudentSignupForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;

  @override
  State<StudentSignupForm> createState() => _StudentSignupFormState();
}

class _StudentSignupFormState extends State<StudentSignupForm> {
  _StudentSignupFormState();
  final _formKey = GlobalKey<FormState>();

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
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomMultiField(
              controller: myTextFieldController,
              fgcolor: widget.fgcolor,
              index: 3,
              hints: const [
                'E-mail',
                'Phone',
                'ID Number',
              ],
              icons: const [
                Icons.alternate_email,
                Icons.call,
                Icons.badge,
              ],
              keyboards: const [
                TextInputType.emailAddress,
                TextInputType.phone,
                TextInputType.number,
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomDatePickField(
              controller: myDateFieldController,
              fgcolor: widget.fgcolor,
            ),
            SizedBox(
              height: size.height * 0.02,
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

                  print(myTextFieldController.text);
                  print(myDateFieldController.text);
                  final docUser = FirebaseFirestore.instance
                      .collection('users')
                      .doc('user' + user_num.toString());
                  user_num += 1;
                  final json = {
                    'user_id': int.parse(myTextFieldController.text),
                  };
                  docUser.set(json);

                  OTPArguments args = OTPArguments(
                    widget.fgcolor,
                    widget.title,
                    widget.icon,
                    CreatePasswordPage(
                      fgcolor: widget.fgcolor,
                      title: widget.title,
                      icon: widget.icon,
                      homeroute: widget.homeroute,
                    ),
                    widget.homeroute,
                  );
                  Navigator.pushNamed(
                    context,
                    OtpScreen.routeName,
                    arguments: args,
                  );
                } else {
                  print("____SignUp Form Error!");
                }
              }, //Todo_Navigation
            ),
          ],
        ),
      ),
    );
  }
}
/*
void read(){
  Stream <list<Users>> readUsers()=>FirebaseFirestore.in
      .collection('users')
      .snapshots()
      .map((snapshot) =>
  snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  static user fromJson(Map<number> json) => User();
  noofusers: json['noofusers']);
}
 */