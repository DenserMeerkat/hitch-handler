import 'package:flutter/material.dart';
import '../../constants.dart';
import 'launch_screen_body.dart';

class LaunchScreen extends StatelessWidget {
  static String routeName = '/launch';
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 52,
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints.maxHeight);
        return LaunchScreenBody(
          maxHeight: constraints.maxHeight,
        );
      }),
      bottomNavigationBar: SizedBox(
        height: 30,
        child: Center(
          child: Text(
            "CTF PROJECTS",
            style: TextStyle(
              letterSpacing: 2.2,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: kTextColor.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
