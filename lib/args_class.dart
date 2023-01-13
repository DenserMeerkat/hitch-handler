import 'package:flutter/material.dart';

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

  OTPArguments(
    this.fgcolor,
    this.title,
    this.icon,
    this.nextPage,
    this.homeroute,
  );
}

class PasswordArguments {
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;

  PasswordArguments(
    this.fgcolor,
    this.title,
    this.icon,
    this.homeroute,
  );
}
