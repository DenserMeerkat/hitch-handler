// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          loading ? const LProgressIndicator() : Container(height: 4),
          Container(
            constraints: const BoxConstraints(maxWidth: 380),
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
