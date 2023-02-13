import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import '../../constants.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';
import 'launch_screen_body.dart';

class LaunchScreen extends StatelessWidget {
  static String routeName = '/launch';
  LaunchScreen({super.key});

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
            borderRadius: 10,
            //showSecondaryButton: false,
          ),
          borderRadius: 10,
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          //debugPrint("$constraints.maxHeight");
          return LaunchScreenBody(
            maxHeight: constraints.maxHeight,
          );
        }),
        bottomNavigationBar: SizedBox(
          height: 30,
          child: Center(
            child: Text(
              "CTF PROJECTS",
              style: TextStyle(
                letterSpacing: 2.2,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? kLTextColor.withOpacity(0.5)
                    : kTextColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
