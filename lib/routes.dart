// import 'package:flutter/material.dart';
// import 'routing_constants.dart';
// import 'screens/home/app.dart';
// import 'screens/launch/launch_screen.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case LaunchViewRoute:
//       return MaterialPageRoute(builder: (context) => const LaunchScreen());
//     case AppViewRoute:
//       return MaterialPageRoute(builder: (context) => const AppScreen());
//     default:
//       return MaterialPageRoute(builder: (context) => const LaunchScreen());
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:hitch_handler/screens/user_home/search_page.dart';
import 'screens/launch/launch_screen.dart';
import 'screens/login/student_login.dart';
import 'screens/login/authority_login.dart';
import 'screens/login/admin_login.dart';
import 'screens/signup/user_signup.dart';
import 'screens/components/otp_screen.dart';
import 'screens/user_home/main_app.dart';

final Map<String, WidgetBuilder> routes = {
  LaunchScreen.routeName: (context) => LaunchScreen(),
  StudentLoginScreen.routeName: (context) => const StudentLoginScreen(),
  AuthorityLoginScreen.routeName: (context) => const AuthorityLoginScreen(),
  AdminLoginScreen.routeName: (context) => const AdminLoginScreen(),
  UserSignUpScreen.routeName: (context) => const UserSignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  AppScreen.routeName: (context) => const AppScreen(),
  SearchPage.routeName: (context) => const SearchPage(),
};
