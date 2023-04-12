import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/popupmenu.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/launch/launch_screen_body.dart';

class LaunchScreen extends StatefulWidget {
  static String routeName = '/launch';
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        exitAppDialog(context);

        return false;
      },
      child: AnimatedTheme(
        duration: const Duration(seconds: 1),
        data: Theme.of(context),
        child: Scaffold(
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
            surfaceTintColor: isDark ? kBackgroundColor : kLBackgroundColor,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return Transform.scale(
                  scaleX: -1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      splashColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      focusColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      highlightColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      hoverColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      splashRadius: 20.0,
                      icon: Icon(
                        Icons.close,
                        color: isDark
                            ? kTextColor.withOpacity(0.9)
                            : kLTextColor.withOpacity(0.9),
                      ),
                      onPressed: () {
                        exitAppDialog(context);
                      },
                      tooltip: "Exit",
                    ),
                  ),
                );
              },
            ),
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
                  color: isDark
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

  void exitAppDialog(BuildContext context) {
    showAlertDialog(
      context,
      "Exit Apllication",
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Click Exit to close app.",
            style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
          ),
        ],
      ),
      [
        buildCancelButton(context),
        buildActiveButton(
          context,
          true,
          "Exit",
          () {
            FlutterExitApp.exitApp(iosForceExit: true);
          },
        )
      ],
      Icons.cancel_outlined,
    );
  }
}
