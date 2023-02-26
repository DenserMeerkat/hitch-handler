import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/auth_methods.dart';
import '../../args_class.dart';
import '../../constants.dart';
import '../components/confirmpasswordform.dart';
import '../components/customsigninappbar.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
    required this.user,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;
  final UserData user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size

    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog(
          context,
          DialogCont(
            title: "Exit Process",
            message:
                "Are you sure you want to go back? You have an ongoing process ",
            icon: Icons.arrow_back,
            iconBackgroundColor: fgcolor.withOpacity(0.7),
            primaryButtonLabel: "Exit",
            primaryButtonColor: kGrey150,
            secondaryButtonColor: fgcolor.withOpacity(0.7),
            primaryFunction: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.popUntil(context, ModalRoute.withName(homeroute));
            },
            secondaryFunction: () {
              Navigator.pop(context);
            },
            borderRadius: 10,
          ),
          borderRadius: 10,
          barrierColor: kBlack10,
        );
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
              size: size,
              fgcolor: fgcolor,
              title: title,
              icon: icon,
              press: () {
                showConfirmDialog(
                  context,
                  DialogCont(
                    title: "Exit Process",
                    message:
                        "Are you sure you want to go back? You have an ongoing process ",
                    icon: Icons.arrow_back,
                    iconBackgroundColor: fgcolor.withOpacity(0.7),
                    primaryButtonLabel: "Exit",
                    primaryButtonColor: kGrey150,
                    secondaryButtonColor: fgcolor.withOpacity(0.7),
                    primaryFunction: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.popUntil(
                          context, ModalRoute.withName(homeroute));
                    },
                    secondaryFunction: () {
                      Navigator.pop(context);
                    },
                    borderRadius: 10,
                  ),
                  borderRadius: 10,
                  barrierColor: kBlack10,
                );
              }),
        ),
        body: ConfirmPasswordBody(
          title: "Create Password",
          subtitle: "Create a password for your account.",
          fgcolor: fgcolor,
          user: user,
          authentication: 1, //Todo
        ),
      ),
    );
  }
}
