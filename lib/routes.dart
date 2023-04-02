import 'package:flutter/material.dart';
import 'widget_tree.dart';
import 'screens/common/settings_page.dart';
import 'screens/common/post_page.dart';
import 'screens/auth_home/auth_app.dart';
import 'screens/user_home/search_page.dart';
import 'screens/launch/launch_screen.dart';
import 'screens/login/student_login.dart';
import 'screens/login/authority_login.dart';
import 'screens/login/admin_login.dart';
import 'screens/signup/user_signup.dart';
import 'screens/common/otp_screen.dart';
import 'screens/user_home/user_app.dart';

final Map<String, WidgetBuilder> routes = {
  LaunchScreen.routeName: (context) => const LaunchScreen(),
  StudentLoginScreen.routeName: (context) => const StudentLoginScreen(),
  AuthorityLoginScreen.routeName: (context) => const AuthorityLoginScreen(),
  AdminLoginScreen.routeName: (context) => const AdminLoginScreen(),
  UserSignUpScreen.routeName: (context) => const UserSignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  AppScreen.routeName: (context) => const AppScreen(),
  SearchPage.routeName: (context) => const SearchPage(),
  SettingsPage.routeName: (context) => const SettingsPage(),
  PostsPage.routeName: (context) => const PostsPage(),
  AuthAppScreen.routeName: (context) => const AuthAppScreen(),
  WidgetTree.routeName: (context) => const WidgetTree(),
};
