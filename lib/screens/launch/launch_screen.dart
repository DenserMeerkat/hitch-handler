import 'package:flutter/material.dart';
import 'launch_screen_body.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: LaunchScreenBody(),
    );
  }
}
