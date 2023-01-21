import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../args_class.dart';
import '../components/customfields/customdatepickfield.dart';
import '../components/utils/customdialog.dart';
import 'create_password.dart';
import '../components/otp_screen.dart';
import '../../constants.dart';
import '../components/customfields/customsubmitbutton.dart';
import '../components/customfields/custommultifield.dart';

final countRef = FirebaseFirestore.instance.collection('count').doc('users');

Future<int> getCount() async {
  var userCount = await countRef.get();
  int count = userCount['count'];
  return count;
}

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
  final user_num = 0;

  @override
  State<StudentSignupForm> createState() => _StudentSignupFormState();
}

class _StudentSignupFormState extends State<StudentSignupForm> {
  _StudentSignupFormState();
  final _formKey = GlobalKey<FormState>();

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
              height: size.height * 0.04,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: kPrimaryColor,
              msg: "Continue",
              fsize: 18,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print("____SignUp Form Valid!");

                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  UserData user = UserData(
                    myTextFieldController.text,
                    '0000000000', //Todo UserData
                    '2021000000', //Todo UserData
                    '**********', //Todo UserData
                    myDateFieldController.text,
                  );
                  print(myTextFieldController.text);
                  print(myDateFieldController.text);
                  // final docUser = FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc('user' + getCount.toString());
                  // //user_num += 1;
                  // final json = {
                  //   'user_id': myTextFieldController.text,
                  //   'dob': myDateFieldController.text,
                  // };
                  // docUser.set(json);

                  OTPArguments args = OTPArguments(
                    widget.fgcolor,
                    widget.title,
                    widget.icon,
                    CreatePasswordPage(
                      fgcolor: widget.fgcolor,
                      title: widget.title,
                      icon: widget.icon,
                      homeroute: widget.homeroute,
                      user: user,
                    ),
                    widget.homeroute,
                    user,
                  );
                  Navigator.pushNamed(
                    context,
                    OtpScreen.routeName,
                    arguments: args,
                  );
                } else {
                  final snackBar = customSnackBar(
                    "One or more Fields have Errors",
                    "Ok",
                    () {},
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar)
                      .closed
                      .then((value) =>
                          ScaffoldMessenger.of(context).clearSnackBars());
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