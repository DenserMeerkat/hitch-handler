import 'package:flutter/material.dart';
import '../../args_class.dart';
import '../../constants.dart';
import '../login/admin_login.dart';
import '../login/authority_login.dart';
import '../login/student_login.dart';
import '../signup/user_signup.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName(arguments.homeroute));
        return false;
      },
      child: Theme(
        data: ThemeData(
          accentColor: arguments.fgcolor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        ),
        child: Scaffold(
          backgroundColor: kGrey30,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: size.height * 0.18,
            backgroundColor: kBackgroundColor,
            elevation: 0,
            flexibleSpace: CustomSignInAppBar(
              size: size,
              fgcolor: arguments.fgcolor,
              title: arguments.title,
              icon: arguments.icon,
              press: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(arguments.homeroute));
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: size.height * 0.770,
              width: size.width,
              color: kGrey30,
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
                  const FittedBox(
                    child: Text(
                      "OTP Verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
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
                          color: kTextColor.withOpacity(0.7),
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
      ),
    );
  }
}
