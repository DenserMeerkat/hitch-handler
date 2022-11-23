import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customsigninappbar.dart';
import 'otpform.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.18,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        flexibleSpace: CustomSignInAppBar(
          size: size,
          fgcolor: fgcolor,
          title: title,
          icon: icon,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.770,
          width: size.width,
          color: const Color.fromRGBO(30, 30, 30, 1),
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
              const Text(
                "OTP Verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text("An OTP has been sent to 91****2345"),
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
                fgcolor: fgcolor,
                index: 2,
                title: title,
                icon: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
