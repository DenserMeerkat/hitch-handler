import 'package:flutter/material.dart';
import 'utils/customdialog.dart';
import 'utils/dialogcont.dart';
import '../../args_class.dart';
import '../../constants.dart';
import 'customsigninappbar.dart';
import 'otpform.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = '/otp_screen';
  const OtpScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as OTPArguments;
    Size size = MediaQuery.of(context).size; // Available screen size

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog(
          context,
          DialogCont(
            title: "Exit Process",
            message:
                "Are you sure you want to go back? You have an ongoing process ",
            icon: Icons.arrow_back,
            iconBackgroundColor: arguments.fgcolor.withOpacity(0.7),
            primaryButtonLabel: "Exit",
            primaryButtonColor: kGrey150,
            secondaryButtonColor: arguments.fgcolor.withOpacity(0.7),
            primaryFunction: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.popUntil(
                  context, ModalRoute.withName(arguments.homeroute));
            },
            secondaryFunction: () {
              Navigator.pop(context);
            },
            borderRadius: 10,
          ),
          borderRadius: 10,
          barrierColor: kBlack10,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: isDark ? kGrey30 : kLGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kHeaderHeight,
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            size: size,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            press: () {
              showConfirmDialog(
                context,
                DialogCont(
                  title: "Exit Process",
                  message:
                      "Are you sure you want to go back? You have an ongoing process ",
                  icon: Icons.arrow_back,
                  iconBackgroundColor: arguments.fgcolor.withOpacity(0.7),
                  primaryButtonLabel: "Exit",
                  primaryButtonColor: kGrey150,
                  secondaryButtonColor: arguments.fgcolor.withOpacity(0.7),
                  primaryFunction: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Navigator.popUntil(
                        context, ModalRoute.withName(arguments.homeroute));
                  },
                  secondaryFunction: () {
                    Navigator.pop(context);
                  },
                  borderRadius: 10,
                ),
                borderRadius: 10,
                barrierColor: kBlack10,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height * 0.770,
            width: size.width,
            color: isDark ? kGrey30 : kLGrey30,
            padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                FittedBox(
                  child: Text(
                    "OTP Verification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? kTextColor : kLTextColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const FittedBox(
                    child: Text("An OTP has been sent to 91****2345")),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Resend code in ",
                      style: TextStyle(
                        color: isDark
                            ? kTextColor.withOpacity(0.7)
                            : kLTextColor.withOpacity(0.8),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    TweenAnimationBuilder(
                        tween: Tween(begin: 60.0, end: 0),
                        duration: const Duration(seconds: 60),
                        builder: (context, value, child) {
                          value = value.toInt();
                          String counter;
                          if (value.toInt() < 10) {
                            counter = '0$value';
                          } else {
                            counter = value.toString();
                          }
                          return Text("00:$counter");
                        }),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                OtpForm(
                  fgcolor: arguments.fgcolor,
                  index: 2,
                  title: arguments.title,
                  icon: arguments.icon,
                  nextPage: arguments.nextPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
