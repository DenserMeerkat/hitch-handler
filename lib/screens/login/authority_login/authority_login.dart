// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../login_form.dart';
import 'authority_login_body.dart';

class AuthorityLoginScreen extends StatelessWidget {
  const AuthorityLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: AuthorityLoginBody(
        title: "Authority",
        fgcolor: kAuthorityColor,
        formwidget: LoginForm(
          fgcolor: kAuthorityColor,
        ),
      )),
    );
  }
}
