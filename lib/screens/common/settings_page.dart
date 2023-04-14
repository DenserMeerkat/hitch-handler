// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/components/utils/resetpassdialog.dart';
import 'package:hitch_handler/screens/components/utils/themedialog.dart';
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

class AccountTile extends StatefulWidget {
  const AccountTile({super.key});

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? kGrey30 : kLGrey30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: AdaptiveTheme.of(context).theme.copyWith(
              brightness: AdaptiveTheme.of(context).brightness,
              useMaterial3: true,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tilePadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          textColor: isDark ? kTextColor : kLTextColor,
          collapsedTextColor: isDark ? kTextColor : kLTextColor,
          iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
          collapsedIconColor: isDark ? kTextColor : kLTextColor,
          backgroundColor: isDark ? kGrey30 : kLBlack10,
          collapsedBackgroundColor: isDark ? kGrey30 : kLBlack10,
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Initicon(
              text: user.name,
              backgroundColor: isDark
                  ? kPrimaryColor.withOpacity(0.8)
                  : kLPrimaryColor.withOpacity(0.8),
              size: 40,
              elevation: 2,
              border: Border.all(
                  width: 0.5, color: isDark ? Colors.transparent : kGrey30),
              style: TextStyle(
                  color: isDark ? kLTextColor : kLTextColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          title: AutoSizeText(
            user.name,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            "Department  •  Year",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              letterSpacing: 1,
              fontSize: 11.0,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          children: <Widget>[
            AccountListTile(
              text: user.rollno,
              icon: Icons.badge_outlined,
            ),
            AccountListTile(
              text: user.email,
              icon: Icons.alternate_email,
            ),
            AccountListTile(
              text: user.mobno,
              icon: Icons.numbers,
            ),
            AccountListTile(
              text: user.dob,
              icon: Icons.calendar_month_outlined,
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key,
    required this.text,
    required this.icon,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? kGrey40 : kLBlack15.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? kPrimaryColor : kPrimaryColor,
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? kTextColor : kLTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? press;
  const SettingTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).theme.brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.0),
      child: ListTileTheme(
        tileColor: isDark ? kGrey30 : kLBlack10,
        textColor: isDark ? kTextColor : kLTextColor,
        iconColor:
            isDark ? kTextColor.withOpacity(0.8) : kLTextColor.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDark ? Colors.transparent : kLGrey30,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: press ?? press,
          leading: Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isDark
                      ? kPrimaryColor.withOpacity(0.2)
                      : kLPrimaryColor.withOpacity(0.4)),
              color: isDark
                  ? kPrimaryColor.withOpacity(0.3)
                  : kLPrimaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              shadows: [
                BoxShadow(
                  blurRadius: 10,
                  color: isDark ? Colors.transparent : kLGrey30,
                ),
              ],
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: isDark ? kTextColor : kLTextColor, fontSize: 14),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(
                      color: isDark
                          ? kTextColor.withOpacity(0.7)
                          : kLTextColor.withOpacity(0.7),
                      fontSize: 12),
                )
              : null,
        ),
      ),
    );
  }
}
