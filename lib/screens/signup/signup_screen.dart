// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customsigninappbar.dart';
import 'package:hitch_handler/screens/components/loginsignupfooter.dart';
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:hitch_handler/screens/login/login_screen.dart';
import 'package:hitch_handler/screens/signup/signupbody.dart';
import 'package:hitch_handler/screens/signup/studentsignupform.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

class UserSignUpScreen extends StatefulWidget {
  static String routeName = '/student_signup';
  const UserSignUpScreen({
    super.key,
  });
  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen>
    with TickerProviderStateMixin {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final arguments =
        ModalRoute.of(context)?.settings.arguments as LoginSignUpArguments;
    Size size = MediaQuery.of(context).size; // Available screen size

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushReplacementNamed(context, LoginScreen.routeName,
            arguments: LoginSignUpArguments(
              "StudentHero",
              isDark ? kStudentColor : kLStudentColor,
              "Student / Staff",
              Icons.school,
            ));
        return true;
      },
      child: Scaffold(
        backgroundColor: isDark ? kGrey30 : kLGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kHeaderHeight.h,
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            fgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
            title: arguments.title,
            icon: arguments.icon,
            leadingAction: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName,
                  arguments: LoginSignUpArguments(
                    "StudentHero",
                    isDark ? kPrimaryColor : kLPrimaryColor,
                    "Login",
                    Icons.account_circle_rounded,
                  ));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              loading ? const LProgressIndicator() : Container(),
              SizedBox(
                child: SignupBody(
                  formwidget: NotificationListener<IsLoading>(
                    onNotification: (n) {
                      setState(() {
                        loading = n.isLoading;
                      });
                      return true;
                    },
                    child: StudentSignupForm(
                      fgcolor: arguments.fgcolor,
                      title: arguments.title,
                      icon: arguments.icon,
                      homeroute: UserSignUpScreen.routeName,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: LoginSignUpFooter(
          size: size,
          msg: "Already have an account ?",
          btntext: "Login",
          fsize: 15,
          press: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName,
                arguments: LoginSignUpArguments(
                  "StudentHero",
                  isDark ? kPrimaryColor : kLPrimaryColor,
                  "Login",
                  Icons.account_circle_rounded,
                ));
          }, //Todo_navigation
        ),
      ),
    );
  }
}
