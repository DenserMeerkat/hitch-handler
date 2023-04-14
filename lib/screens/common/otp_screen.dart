// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/common/otpform.dart';
import 'package:hitch_handler/screens/components/customsigninappbar.dart';
import 'package:hitch_handler/screens/components/utils/exitdialog.dart';
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = '/otp_screen';
  const OtpScreen({
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late bool loading = false;
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as OTPArguments;
    // debugPrint(arguments.user.rollno);
    // debugPrint(arguments.user.name);
    // debugPrint(arguments.user.email);
    // debugPrint(arguments.user.gender);
    // debugPrint(arguments.user.clg);
    // debugPrint(arguments.user.password);
    // debugPrint(arguments.user.mobno);
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        exitDialog(context, arguments.homeroute);
        return false;
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
            title: arguments.title,
            icon: arguments.icon,
            showActions: false,
            leadingAction: () {
              exitDialog(context, arguments.homeroute);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 520.h,
            width: 360.w,
            color: isDark ? kGrey30 : kLGrey30,
            padding: EdgeInsets.only(
              top: 30.h,
              left: 30.w,
              right: 30.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                loading ? const LProgressIndicator() : Container(height: 4),
                SizedBox(
                  height: 15.h,
                ),
                FittedBox(
                  child: Text(
                    "OTP Verification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? kTextColor : kLTextColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 32.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FittedBox(
                  child: Text(
                    "An OTP has been sent to ${obscure(arguments.user.mobno)}",
                    style: AdaptiveTheme.of(context).theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                NotificationListener<IsLoading>(
                  child: OtpForm(
                    user: arguments.user,
                    fgcolor: kStudentColor,
                    index: 2,
                    title: "Password",
                    icon: Icons.key_rounded,
                    nextPage: arguments.nextPage,
                  ),
                  onNotification: (n) {
                    setState(() {
                      loading = n.isLoading;
                    });
                    return true;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String obscure(String phone) {
    return phone.replaceRange(2, 7, "*****");
  }
}
