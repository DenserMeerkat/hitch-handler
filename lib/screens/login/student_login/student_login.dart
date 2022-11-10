// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'student_login_body.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        foregroundColor: kTextColor,
        elevation: 0,
        title: Text(
          "HITCH  HANDLER",
        ),
        titleTextStyle: TextStyle(
          color: kTextColor.withOpacity(0.7),
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 2,
        ),
        centerTitle: true,
      ),
      body: StudentLoginBody(),
    );
  }
}
