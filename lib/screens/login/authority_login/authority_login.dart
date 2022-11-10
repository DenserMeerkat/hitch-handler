// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/login/authority_login/authority_login_body.dart';

class AuthorityLoginScreen extends StatelessWidget {
  const AuthorityLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: AuthorityLoginBody(),
    );
  }
}
