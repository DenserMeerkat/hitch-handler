import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class LoginSignUpFooter extends StatelessWidget {
  const LoginSignUpFooter({
    Key? key,
    required this.size,
    required this.msg,
    required this.btntext,
    required this.fsize,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String msg;
  final String btntext;
  final double fsize;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.h),
                  child: Text(
                    msg,
                    style: TextStyle(
                      fontSize: fsize.sp,
                      letterSpacing: 1.sp,
                      color: isDark ? kTextColor.withOpacity(0.8) : kLTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    )),
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return isDark
                            ? kTextColor.withOpacity(0.1)
                            : kLTextColor.withOpacity(0.1);
                      }
                      return null;
                    }),
                  ),
                  onPressed: press, //todo,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.r),
                      border: Border.all(
                        width: 2.0.w,
                        color: isDark
                            ? kTextColor.withOpacity(0.7)
                            : kLTextColor.withOpacity(0.7),
                      ),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          btntext,
                          style: TextStyle(
                            color: isDark ? kTextColor : kLTextColor,
                            letterSpacing: 1.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
