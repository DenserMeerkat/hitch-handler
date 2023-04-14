// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/confirmpasswordform.dart';
import 'package:hitch_handler/screens/components/customsigninappbar.dart';
import 'package:hitch_handler/screens/components/utils/exitdialog.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({
    super.key,
    required this.title,
    required this.icon,
    required this.homeroute,
    required this.user,
  });
  final String title;
  final IconData icon;
  final String homeroute;
  final UserData user;
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        exitDialog(context, homeroute);
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
              title: title,
              icon: icon,
              showActions: false,
              leadingAction: () {
                exitDialog(context, homeroute);
              }),
        ),
        body: ConfirmPasswordBody(
          title: "Create Password",
          subtitle: "Create a password for your account.",
          fgcolor: kStudentColor,
          user: user,
          authentication: 1, //Todo
        ),
      ),
    );
  }
}
