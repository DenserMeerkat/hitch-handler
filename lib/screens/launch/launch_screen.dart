import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../components/popupmenu.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';
import 'launch_screen_body.dart';

class LaunchScreen extends StatefulWidget {
  static String routeName = '/launch';
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog(
          context,
          DialogCont(
            title: "Exit",
            message: "Click Exit to close app. ",
            icon: Icons.exit_to_app_rounded,
            iconBackgroundColor:
                Theme.of(context).brightness == Brightness.light
                    ? kLPrimaryColor
                    : kPrimaryColor,
            primaryButtonLabel: "Exit",
            primaryButtonColor: kGrey150,
            secondaryButtonColor:
                Theme.of(context).brightness == Brightness.light
                    ? kLPrimaryColor
                    : kPrimaryColor,
            primaryFunction: () {
              FlutterExitApp.exitApp(iosForceExit: true);
            },
            secondaryFunction: () {
              Navigator.pop(context);
            },
            borderRadius: 10.r,
            //showSecondaryButton: false,
          ),
          borderRadius: 10.r,
        );
        return false;
      },
      child: AnimatedTheme(
        duration: const Duration(seconds: 1),
        data: Theme.of(context),
        child: Scaffold(
          backgroundColor:
              AdaptiveTheme.of(context).brightness == Brightness.dark
                  ? kBackgroundColor
                  : kLBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:
                AdaptiveTheme.of(context).brightness == Brightness.dark
                    ? kBackgroundColor
                    : kLBackgroundColor,
            surfaceTintColor:
                AdaptiveTheme.of(context).brightness == Brightness.dark
                    ? kBackgroundColor
                    : kLBackgroundColor,
            elevation: 0,
            actions: [
              const PopupMenu(),
              SizedBox(
                width: 12.w,
              )
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            //debugPrint("$constraints.maxHeight");
            //debugPrint("$constraints.maxWidth");
            return const LaunchScreenBody();
          }),
          bottomNavigationBar: SizedBox(
            height: 30.h,
            child: Center(
              child: Text(
                "CTF PROJECTS",
                style: TextStyle(
                  letterSpacing: 2.2.sp,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AdaptiveTheme.of(context).brightness == Brightness.dark
                      ? kTextColor.withOpacity(0.5)
                      : kLTextColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
