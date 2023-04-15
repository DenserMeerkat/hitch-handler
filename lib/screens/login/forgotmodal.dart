// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../args_class.dart';
import '../../constants.dart';
import '../common/otp_screen.dart';
import '../components/customfields/custommultifield.dart';
import '../components/customfields/customsubmitbutton.dart';
import 'reset_password.dart';

class ForgotModalForm extends StatefulWidget {
  const ForgotModalForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;
  final int? index;
  @override
  State<ForgotModalForm> createState() => ForgotModalFormState();
}

class ForgotModalFormState extends State<ForgotModalForm> {
  ForgotModalFormState();
  final _formKey = GlobalKey<FormState>();

  final myTextFieldController = TextEditingController();

  @override
  void dispose() {
    myTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.h,
            child: Center(
              child: Container(
                height: 5,
                width: 50.w,
                decoration: BoxDecoration(
                  color: isDark
                      ? kTextColor.withOpacity(0.5)
                      : kLTextColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: isDark ? kGrey40 : kLGrey50,
            height: 2,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 380),
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 30),
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: AutoSizeText(
                    "Forgot Password ?",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style:
                        AdaptiveTheme.of(context).theme.textTheme.headlineLarge,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: FittedBox(
                    child: Text(
                      "Enter registered Email ID / Mobile Number.",
                      style:
                          AdaptiveTheme.of(context).theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                CustomMultiField(
                  controller: myTextFieldController,
                  fgcolor: widget.fgcolor,
                  index: 3,
                  hints: const [
                    'E-mail',
                    'Phone',
                    'ID Number',
                  ],
                  icons: const [
                    Icons.alternate_email,
                    Icons.call,
                    Icons.badge,
                  ],
                  keyboards: const [
                    TextInputType.emailAddress,
                    TextInputType.phone,
                    TextInputType.number,
                  ],
                ),
                CustomSubmitButton(
                  size: size,
                  bgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
                  msg: "Send Code",
                  fsize: 20,
                  width: 2.5,
                  press: () {
                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint("____Forgot Form Valid!");

                      UserData user = UserData(
                        '---',
                        "name",
                        myTextFieldController.text,
                        '0000000000',
                        '2021000000',
                        '********',
                        '00-00-0000',
                        '-',
                      );

                      OTPArguments args = OTPArguments(
                        kPrimaryColor,
                        "Verify",
                        Icons.task_alt,
                        ResetPasswordPage(
                          fgcolor: widget.fgcolor,
                          title: "Password",
                          icon: Icons.key_rounded,
                          homeroute: widget.homeroute,
                          user: user,
                        ),
                        widget.homeroute,
                        user,
                      );
                      Navigator.pushNamed(
                        context,
                        OtpScreen.routeName,
                        arguments: args,
                      );
                      debugPrint(myTextFieldController.text);
                    } else {
                      debugPrint("____Forgot Form Error!");
                    }
                  }, //Todo_Navigation
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
