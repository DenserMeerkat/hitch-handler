// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../login_form.dart';
import 'admin_login_body.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: AdminLoginBody(
        title: "Admin",
        fgcolor: kAdminColor,
        formwidget: LoginForm(
          fgcolor: kAdminColor,
        ),
      )),
    );
  }
}
