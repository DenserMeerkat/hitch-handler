import 'package:flutter/material.dart';
import '../../models/user.dart' as model;

class UserData {
  String email;
  String mobno;
  String rollno;
  String password;
  String dob;
  UserData(
    this.email,
    this.mobno,
    this.rollno,
    this.password,
    this.dob,
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

  PostsArguments(
    this.snap,
  );
}
