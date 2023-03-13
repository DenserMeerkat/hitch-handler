import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/string_extensions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart' as model;
import '../../providers/user_provider.dart';
import '../launch/launch_screen.dart';

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
    Size size = MediaQuery.of(context).size;

    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      backgroundColor: isDark ? kBackgroundColor : kLBlack20
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
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
                        Navigator.of(context).pop();
                      },
                      tooltip: "Back",
                    ),
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            child: ListView(
              shrinkWrap: true,
              children: [
                const AccountTile(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.0),
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
                                      .bodyLarge!
                                      .copyWith(fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                // Chip(
                                //   padding: const EdgeInsets.symmetric(
                                //       vertical: 12, horizontal: 8),
                                //   backgroundColor: isDark ? kGrey50 : kLBlack15,
                                //   surfaceTintColor:
                                //       isDark ? kGrey50 : kLBlack15,
                                //   side: BorderSide(
                                //     width: 1.5,
                                //     color: isDark
                                //         ? kTextColor.withOpacity(0.05)
                                //         : kLTextColor.withOpacity(0.05),
                                //   ),
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(8),
                                //   ),
                                //   label: FittedBox(
                                //     child: Text(
                                //       user.email,
                                //       style: TextStyle(
                                //         color: isDark
                                //             ? kTextColor.withOpacity(0.7)
                                //             : kLTextColor.withOpacity(0.7),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                  final scaffold =
                                      ScaffoldMessenger.of(context);
                                  await AuthMethods().signOut();
                                  scaffold.removeCurrentSnackBar();
                                  navigator.pushNamedAndRemoveUntil(
                                      LaunchScreen.routeName,
                                      (Route<dynamic> route) => false);
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
        ],
      ),
    );
  }
}

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({
    super.key,
  });

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController myTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool submit = false;
  bool clear = false;
  @override
  void dispose() {
    myTextFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    myTextFieldController.addListener(() {
      setState(() {
        clear = myTextFieldController.text.isNotEmpty;
        submit = myTextFieldController.text.trim() == user.email;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    OutlineInputBorder border(Color color) {
      OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
      return outlineInputBorder;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      title: Row(
        children: [
          const FittedBox(
            child: Icon(
              MdiIcons.lockReset,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Rest Password',
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            "An email will be sent with instructions.",
            style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
          ),
          Text(
            "Please type your email to confirm.",
            style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Form(
            key: _formkey,
            child: Container(
              constraints: BoxConstraints(maxWidth: 270.w),
              //height: 44,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                validator: (value) {
                  return validateEmail(value);
                },
                controller: myTextFieldController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(top: 4, bottom: 4, left: 16),
                  border: border(Colors.transparent),
                  focusedBorder: border(kPrimaryColor),
                  errorBorder:
                      border(AdaptiveTheme.of(context).theme.colorScheme.error),
                  enabledBorder: border(isDark ? kGrey70 : kLBlack20),
                  disabledBorder: border(Colors.transparent),
                  suffixIconColor: kPrimaryColor,
                  suffixIcon: clear
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              myTextFieldController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        )
                      : const Icon(
                          Icons.alternate_email_outlined,
                        ),
                  hintText: "Email",
                  hintStyle: AdaptiveTheme.of(context)
                      .theme
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        color: isDark
                            ? kTextColor.withOpacity(0.5)
                            : kLTextColor.withOpacity(0.5),
                      ),
                  fillColor: isDark ? kGrey50 : kLBlack15,
                  filled: true,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        buildCancelButton(context),
        buildActiveButton(
            context,
            submit,
            "Confirm",
            submit
                ? () {
                    if (_formkey.currentState!.validate()) {
                      AuthMethods()
                          .passReset(myTextFieldController.text.trim());
                      debugPrint("Print");
                      Navigator.of(context).pop();
                    } else {
                      debugPrint("Error");
                    }
                  }
                : null),
      ],
    );
  }

  String? validateEmail(String? value) {
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    if (value!.isWhitespace()) {
      return "Email can\t be empty";
    } else if (value == user.email) {
      return null;
    } else {
      return "Incorrect Email";
    }
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: isDark ? kBlack20 : kGrey30,
                      ),
                    ),
                    child: CircleAvatar(
                      minRadius: 40,
                      maxRadius: 40.w,
                      backgroundColor: isDark ? kGrey30 : kGrey50,
                      child: AutoSizeText(
                        "JD",
                        style: AdaptiveTheme.of(context)
                            .theme
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                          color: kTextColor.withOpacity(0.8),
                          shadows: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              color: isDark ? kBlack10 : kGrey30,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  child: const AutoSizeText(
                    "3 Posts",
                    style: TextStyle(color: kTextColor),
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
                    "John Doe",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                  AutoSizeText(
                    user.email,
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
                  AutoSizeText(
                    user.uid,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
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
