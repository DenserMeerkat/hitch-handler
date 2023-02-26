import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import '../../constants.dart';
import 'customfields/customsubmitbutton.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.nextPage,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final int? index;
  final Widget nextPage;
  @override
  State<OtpForm> createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  OtpFormState();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String otp = "";

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 58.h,
      textStyle: AdaptiveTheme.of(context)
          .theme
          .textTheme
          .headlineLarge!
          .copyWith(fontSize: 20, color: isDark ? kTextColor : kLTextColor),
      decoration: BoxDecoration(color: widget.fgcolor.withOpacity(0.3)),
    );
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 243.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: isDark ? kGrey30 : kLBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 2),
                      color: isDark ? kBlack20 : kGrey150,
                      //blurRadius: 5,
                    )
                  ]),
              child: Pinput(
                length: 4,
                controller: pinController,
                focusNode: focusNode,
                separator: Container(
                  height: 58.h,
                  width: 2.w,
                  color: isDark ? kGrey30 : kLGrey30,
                ),
                keyboardAppearance: AdaptiveTheme.of(context).brightness,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                focusedPinTheme: defaultPinTheme.copyWith(
                    decoration:
                        BoxDecoration(color: widget.fgcolor.withOpacity(0.9))),
              ),
            ),
            // OTPTextField(
            //   length: 4,
            //   width: size.width,
            //   spaceBetween: 0,
            //   fieldWidth: 50,
            //   contentPadding:
            //       EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
            //   otpFieldStyle: OtpFieldStyle(
            //     backgroundColor: isDark ? kBlack20 : kLGrey40,
            //     borderColor: isDark ? kTextColor.withOpacity(0.2) : kLTextColor,
            //     focusBorderColor: widget.fgcolor,
            //     disabledBorderColor: Colors.grey,
            //     enabledBorderColor:
            //         isDark ? kTextColor.withOpacity(0.2) : kLTextColor,
            //     errorBorderColor: Colors.red,
            //   ),
            //   style: const TextStyle(fontSize: 30),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   outlineBorderRadius: 5.0,
            //   fieldStyle: FieldStyle.box,
            //   cursorColor: widget.fgcolor,
            //   onChanged: (value) {},
            //   onCompleted: (pin) {
            //     print("Completed: " + pin); //Todo
            //     otp = pin;
            //   },
            // ),
            //Pinput(),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kSecButtonColor,
                    msg: "Resend",
                    fsize: 20.sp,
                    press: () {}, //Todo
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kPrimaryColor,
                    msg: "Submit",
                    fsize: 20.sp,
                    press: () {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("___________________");
                        print(_formKey.currentState!.validate());
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return widget.nextPage;
                          }),
                        );
                        print("OTP : " + otp);
                      } else {
                        print(">>>>>ERRORS!");
                      }
                    }, //Todo_Navigation
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
