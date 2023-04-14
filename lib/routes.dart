// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:hitch_handler/screens/auth_home/auth_app.dart';
import 'package:hitch_handler/screens/common/otp_screen.dart';
import 'package:hitch_handler/screens/common/post_page.dart';
import 'package:hitch_handler/screens/common/settings_page.dart';
import 'package:hitch_handler/screens/login/login_screen.dart';
import 'package:hitch_handler/screens/signup/signup_screen.dart';
import 'package:hitch_handler/screens/user_home/search_page.dart';
import 'package:hitch_handler/screens/user_home/user_app.dart';
import 'package:hitch_handler/widget_tree.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  UserSignUpScreen.routeName: (context) => const UserSignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  AppScreen.routeName: (context) => const AppScreen(),
  SearchPage.routeName: (context) => const SearchPage(),
  SettingsPage.routeName: (context) => const SettingsPage(),
  PostsPage.routeName: (context) => const PostsPage(),
  AuthAppScreen.routeName: (context) => const AuthAppScreen(),
  WidgetTree.routeName: (context) => const WidgetTree(),
};
