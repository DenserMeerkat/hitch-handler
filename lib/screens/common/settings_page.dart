import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/screens/components/utils/resetpassdialog.dart';
import 'package:hitch_handler/screens/components/utils/themedialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:provider/provider.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/launch/launch_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'dart:async';

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
              SizedBox(height: 20.h),
              const AccountTile(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.0),
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
                                    LaunchScreen.routeName,
                                    (Route<dynamic> route) => false);
                                await AuthMethods().signOut();
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
  late String posts = "loading...";

  @override
  Widget build(BuildContext context) {
    getData();
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    TextStyle textStyle = AdaptiveTheme.of(context).theme.textTheme.bodyMedium!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.0),
        decoration: BoxDecoration(
          color: isDark ? kGrey40 : kLBlack10,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    color: isDark ? kBlack20 : kLGrey50,
                    blurRadius: 5,
                  ),
                ]
              : null,
          border: isDark ? null : Border.all(color: kLGrey30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Initicon(
                      text: user.name,
                      backgroundColor: isDark
                          ? kPrimaryColor.withOpacity(0.8)
                          : kLPrimaryColor.withOpacity(0.8),
                      size: 60,
                      elevation: 2,
                      border: Border.all(
                          width: 0.5,
                          color: isDark ? Colors.transparent : kGrey30),
                      style: TextStyle(
                          color: isDark ? kLTextColor : kLTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    // CircleAvatar(
                    //   minRadius: 40,
                    //   maxRadius: 40.w,
                    //   backgroundColor: isDark ? kGrey30 : kGrey50,
                    //   child: AutoSizeText(
                    //     "JD",
                    //     style: AdaptiveTheme.of(context)
                    //         .theme
                    //         .textTheme
                    //         .headlineLarge!
                    //         .copyWith(
                    //       color: kTextColor.withOpacity(0.8),
                    //       shadows: [
                    //         BoxShadow(
                    //           offset: const Offset(3, 3),
                    //           color: isDark ? kBlack10 : kGrey30,
                    //           blurRadius: 10,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isDark ? kGrey30 : kGrey50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isDark ? kBlack20 : kGrey30,
                    ),
                  ),
                  child: AutoSizeText(
                    posts,
                    style: const TextStyle(color: kTextColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                  AutoSizeText(
                    user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                  Text(
                    user.rollno,
                    style: textStyle,
                  ),
                  Text(
                    user.mobno,
                    style: textStyle,
                  ),
                  Text(
                    user.dob,
                    style: textStyle,
                  ),
                  // AutoSizeText(
                  //   user.uid,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: textStyle,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    Query<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: user.uid);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (mounted) {
      setState(() {
        posts = '${allData.length} posts';
      });
    }
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
        tileColor: isDark ? kGrey30 : kLBlack15,
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
