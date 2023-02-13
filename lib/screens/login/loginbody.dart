import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // Available screen size
    return SingleChildScrollView(
      child: Column(
        children: [
          loading
              ? const LinearProgressIndicator(
                  backgroundColor: kBlack20,
                  color: kPrimaryColor,
                )
              : Container(),
          Container(
            decoration: BoxDecoration(
              color: isDark ? kGrey30 : kLGrey30,
            ),
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                FittedBox(
                  child: Text(
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                FittedBox(
                  child: Text(
                    "Sign In to continue to app.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: size.height * 0.075),
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
