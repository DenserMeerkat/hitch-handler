import 'package:flutter/material.dart';
import '../../constants.dart';
import 'launch_screen_body.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.15,
        backgroundColor: kBackgroundColor,
        // title: Text(
        //   "Hitch Handler",
        //   style: TextStyle(
        //     fontSize: 28.0,
        //     letterSpacing: 1.0,
        //   ),
        // ),
        //flexibleSpace: ,
        elevation: 1,
      ),
      body: LaunchScreenBody(),
    );
  }
}
