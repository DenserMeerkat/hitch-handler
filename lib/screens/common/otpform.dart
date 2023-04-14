// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customfields/customsubmitbutton.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.user,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.nextPage,
    this.index,
  });
  final UserData user;
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
  final countController = CountDownController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String otp = "";
  bool isLoading = false;
  bool isCounting = true;
  final int duration = 151;
  @override
  void initState() {
    super.initState();
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: !isCounting
                      ? () {
                          countController.restart();
                        }
                      : null,
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      return isDark ? Colors.transparent : Colors.transparent;
                    }),
                    shape: MaterialStateProperty.resolveWith((states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      );
                    }),
                  ),
                  child: Transform.translate(
                    offset: const Offset(0, 4),
                    child: Text(
                      "Resend code",
                      style: TextStyle(
                        color: Colors.transparent,
                        shadows: [
                          Shadow(
                              color: !isCounting
                                  ? kPrimaryColor
                                  : isDark
                                      ? kTextColor.withOpacity(0.4)
                                      : kLTextColor.withOpacity(0.4),
                              offset: const Offset(0, -4))
                        ],
                        decoration: TextDecoration.underline,
                        decorationColor: !isCounting
                            ? kPrimaryColor
                            : isDark
                                ? kTextColor.withOpacity(0.4)
                                : kLTextColor.withOpacity(0.4),
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ),
                ),
                Text(
                  " in ",
                  style: TextStyle(
                    color: isDark
                        ? kTextColor.withOpacity(0.7)
                        : kLTextColor.withOpacity(0.8),
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                CircularCountDownTimer(
                  duration: duration,
                  initialDuration: 0,
                  controller: countController,
                  width: 30,
                  height: 30,
                  ringColor: isDark ? kGrey40 : kLGrey30,
                  ringGradient: null,
                  fillColor: kPrimaryColor,
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 3,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 8.0,
                      color: isDark ? kTextColor : kLTextColor,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    debugPrint('Countdown Started');
                    if (!isCounting) {
                      setState(() {
                        isCounting = true;
                      });
                    }
                  },
                  onComplete: () {
                    debugPrint('Countdown Ended');
                    setState(() {
                      isCounting = false;
                    });
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "0";
                    } else {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
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
            SizedBox(
              height: 40.h,
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 5.w,
            //     ),
            //     Expanded(
            //       child: CustomSubmitButton(
            //         size: size,
            //         bgcolor: kSecButtonColor,
            //         msg: "Resend",
            //         fsize: 20.sp,
            //         press: () {}, //Todo
            //       ),
            //     ),
            //     SizedBox(
            //       width: 20.w,
            //     ),
            //     Expanded(
            //       child: CustomSubmitButton(
            //         size: size,
            //         bgcolor: kPrimaryColor,
            //         msg: "Submit",
            //         fsize: 20.sp,
            //         press: () {
            //           WidgetsBinding.instance.focusManager.primaryFocus
            //               ?.unfocus();
            //           if (_formKey.currentState!.validate()) {
            //             _formKey.currentState!.save();
            //             debugPrint("___________________");
            //             debugPrint("${_formKey.currentState!.validate()}");
            //             ScaffoldMessenger.of(context).removeCurrentSnackBar();
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) {
            //                 return widget.nextPage;
            //               }),
            //             );
            //             debugPrint("OTP : $otp");
            //           } else {
            //             debugPrint(">>>>>ERRORS!");
            //           }
            //         }, //Todo_Navigation
            //       ),
            //     ),
            //     SizedBox(
            //       width: 5.w,
            //     ),
            //   ],
            // ),
            CustomSubmitButton(
              size: size,
              bgcolor: kPrimaryColor,
              msg: "Submit",
              fsize: 20.sp,
              width: 2.5,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint("___________________");
                  debugPrint("${_formKey.currentState!.validate()}");
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return widget.nextPage;
                    }),
                  );
                  debugPrint("OTP : $otp");
                } else {
                  debugPrint(">>>>>ERRORS!");
                }
              }, //Todo_Navigation
            ),
          ],
        ),
      ),
    );
  }
}
