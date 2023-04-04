import 'package:flutter/material.dart';

class UserData {
  String clg;
  String name;
  String email;
  String mobno;
  String rollno;
  String password;
  String dob;
  String? gender;
  UserData(
    this.clg,
    this.name,
    this.email,
    this.mobno,
    this.rollno,
    this.password,
    this.dob,
    this.gender,
  );
}

class LoginSignUpArguments {
  final Object herotag;
  final Color fgcolor;
  final String title;
  final IconData icon;

  LoginSignUpArguments(
    this.herotag,
    this.fgcolor,
    this.title,
    this.icon,
  );
}

class OTPArguments {
  final Color fgcolor;
  final String title;
  final IconData icon;
  final Widget nextPage;
  final String homeroute;
  final UserData user;

  OTPArguments(
    this.fgcolor,
    this.title,
    this.icon,
    this.nextPage,
    this.homeroute,
    this.user,
  );
}

class PostsArguments {
  final dynamic snap;
  final bool isAuthority;
  PostsArguments(
    this.snap,
    this.isAuthority,
  );
}
