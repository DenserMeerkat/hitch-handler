import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../user_home/notifiers.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
    required this.formwidget,
  });
  final Widget formwidget;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        children: [
          loading ? const LinearProgressIndicator() : Container(),
          Container(
            decoration: BoxDecoration(
              color: isDark ? kGrey30 : kLGrey30,
            ),
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                FittedBox(
                  child: Text(
                    "Welcome Back!",
                    style:
                        AdaptiveTheme.of(context).theme.textTheme.headlineLarge,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FittedBox(
                  child: Text(
                    "Sign In to continue to app.",
                    style: AdaptiveTheme.of(context).theme.textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: 45.h),
                NotificationListener<IsLoading>(
                  child: widget.formwidget,
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
        ],
      ),
    );
  }
}
