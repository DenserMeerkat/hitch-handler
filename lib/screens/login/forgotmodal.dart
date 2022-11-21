import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customtextfield.dart';
import '../components/customsubmitbutton.dart';
import 'otp_screen.dart';

class ForgotModalForm extends StatefulWidget {
  const ForgotModalForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final int? index;
  @override
  State<ForgotModalForm> createState() =>
      ForgotModalFormState(fgcolor, title, icon);
}

class ForgotModalFormState extends State<ForgotModalForm> {
  ForgotModalFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
  final _formOTPKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formOTPKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.06,
              child: Center(
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            const Text(
              "Forgot Password ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Enter registered Email ID / Mobile Number.",
              style: TextStyle(
                color: kTextColor.withOpacity(0.7),
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            CustomTextField(
              fgcolor: fgcolor,
              index: 2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: kPrimaryColor,
              msg: "Send Code",
              fsize: 18,
              width: 0.08,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return OtpPage(
                      fgcolor: fgcolor,
                      title: title,
                      icon: icon,
                    );
                  }),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
