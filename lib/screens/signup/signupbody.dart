// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../constants.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
    required this.formwidget,
  });
  final Widget formwidget;
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        decoration: BoxDecoration(
          color: isDark ? kGrey30 : kLGrey30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.h,
            ),
            FittedBox(
              child: Text("Create an Account",
                  style:
                      AdaptiveTheme.of(context).theme.textTheme.headlineLarge),
            ),
            SizedBox(
              height: 15.h,
            ),
            FittedBox(
              child: Text(
                "using College Roll Number",
                textAlign: TextAlign.center,
                style: AdaptiveTheme.of(context).theme.textTheme.titleSmall,
              ),
            ),
            SizedBox(height: 45.h),
            formwidget,
          ],
        ),
      ),
    );
  }
}
