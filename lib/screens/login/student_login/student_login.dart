import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/login/login_form.dart';
import '../../../constants.dart';
import 'student_login_body.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: StudentLoginBody(
        title: "Student / Staff",
        fgcolor: kStudentColor,
        formwidget: LoginForm(
          fgcolor: kStudentColor,
        ),
      )),
    );
  }
}
