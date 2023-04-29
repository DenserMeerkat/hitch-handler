// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customsigninappbar.dart';
import 'package:hitch_handler/screens/components/loginsignupfooter.dart';
import 'package:hitch_handler/screens/components/utils/exitappdialog.dart';
import 'package:hitch_handler/screens/login/loginbody.dart';
import 'package:hitch_handler/screens/login/loginform.dart';
import 'package:hitch_handler/screens/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/student_login';
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // Available screen size
    return WillPopScope(
      onWillPop: () async {
        exitAppDialog(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDark ? kGrey30 : kLGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kHeaderHeight.h,
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            fgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
            title: "Sign In",
            icon: MdiIcons.account,
            leadingIcon: Icons.close_rounded,
            leadingToolTip: "Exit",
            leadingAction: () {
              exitAppDialog(context);
            },
          ),
        ),
        body: LoginBody(
          formwidget: LoginForm(
            userIndex: 0,
            fgcolor: kStudentColor,
            title: "Sign In",
            icon: MdiIcons.accountArrowRight,
            homeroute: LoginScreen.routeName,
          ),
        ),
        bottomNavigationBar: LoginSignUpFooter(
          size: size,
          msg: "Don't have an account ?",
          btntext: "Sign Up",
          fsize: 16,
          press: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            LoginSignUpArguments args = LoginSignUpArguments(
              "",
              kStudentColor,
              "Sign Up",
              MdiIcons.accountPlus,
            );

            Navigator.pushNamed(
              context,
              UserSignUpScreen.routeName,
              arguments: args,
            );
          }, //Todo_Navigation
        ),
      ),
    );
  }
}
