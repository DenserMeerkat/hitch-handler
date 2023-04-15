// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/components/utils/resetpassdialog.dart';
import 'package:hitch_handler/screens/components/utils/themedialog.dart';
import 'package:hitch_handler/screens/components/utils/tiles.dart';
import 'package:hitch_handler/screens/login/login_screen.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = '/settings_page';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void launchEmail({
    String email = "auhitchhandler@gmail.com",
    required String subject,
    required String title,
  }) async {
    final url = Uri.parse(
        'mailto:$email?subject=${Uri.encodeFull("[$subject] | $title")}&body=DefaultBody');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getCurrentTheme() {
    switch (AdaptiveTheme.of(context).mode) {
      case AdaptiveThemeMode.system:
        return "System Default";
      case AdaptiveThemeMode.light:
        return "Light Theme";
      case AdaptiveThemeMode.dark:
        return "Dark Theme";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: AdaptiveTheme.of(context).theme.textTheme.headlineMedium,
          ),
          backgroundColor: isDark ? kBackgroundColor : kLBlack20,
          surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
          shadowColor: isDark ? kGrey30 : kLGrey30,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: IconButton(
                    splashColor: splash(isDark),
                    focusColor: splash(isDark),
                    highlightColor: splash(isDark),
                    hoverColor: splash(isDark),
                    style:
                        AdaptiveTheme.of(context).theme.iconButtonTheme.style,
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: isDark ? kTextColor : kLTextColor,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.of(context).pop();
                    },
                    tooltip: "Back",
                  ),
                ),
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.5,
              color: isDark ? kGrey40 : kLGrey40,
            ),
          ),
        ),
        backgroundColor: isDark ? kBackgroundColor : kLBlack20,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40.h),
              const AccountTile(),
              SizedBox(height: 8.h),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(width: 5.w),
                    FilledButton.tonal(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierColor: isDark
                                ? kBlack10.withOpacity(0.8)
                                : kGrey30.withOpacity(0.8),
                            builder: (BuildContext context) {
                              return const ResetPasswordDialog();
                            });
                      },
                      child: const Text("Reset Password"),
                    ),
                    SizedBox(width: 20.w),
                    FilledButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showAlertDialog(
                          context,
                          "Log out",
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Are you sure you want to logout of your account?",
                                style: AdaptiveTheme.of(context)
                                    .theme
                                    .textTheme
                                    .bodyLarge,
                              ),
                            ],
                          ),
                          [
                            buildCancelButton(context),
                            buildActiveButton(
                              context,
                              true,
                              "Log out",
                              () async {
                                final navigator = Navigator.of(context);
                                final scaffold = ScaffoldMessenger.of(context);
                                scaffold.removeCurrentSnackBar();
                                navigator.pushNamedAndRemoveUntil(
                                    LoginScreen.routeName,
                                    (Route<dynamic> route) => false);
                                Future.delayed(const Duration(milliseconds: 10),
                                    () async {
                                  await AuthMethods().signOut();
                                });
                              },
                            )
                          ],
                          Icons.exit_to_app,
                        );
                      },
                      child: const Text("Log out"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SettingTile(
                press: () {
                  showToggleThemeDialog(context);
                },
                title: "Change Theme",
                icon: Icons.palette_outlined,
                subtitle: getCurrentTheme(),
              ),
              SettingTile(
                press: () {
                  launchEmail(subject: "Bug", title: "Bug Report");
                },
                title: "Report a Bug",
                subtitle: "Opens default email app",
                icon: Icons.bug_report_outlined,
              ),
              SettingTile(
                press: () {
                  launchEmail(subject: "Feature", title: "Feature Request");
                },
                title: "Request Feature",
                subtitle: "Opens default email app",
                icon: Icons.new_releases_outlined,
              ),
              SettingTile(
                press: () {
                  showAboutDialog(context: context);
                },
                title: "About App",
                icon: Icons.info_outline,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
