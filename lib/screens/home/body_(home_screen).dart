// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/home/buttons_container_(body).dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height - 91,
        child: Stack(
          children: [
            // Bottom Text ("CTF PROJECTS")
            BottomText(),
            // Buttons Container
            ButtonsContainer(size: size),
            // Logo Container
            LogoContainer(size: size), //Todo
          ],
        ),
      ),
    );
  }
}

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: size.height * 0.45,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      height: size.height * 0.02,
      bottom: 0,
      right: 0,
      left: 0,
      child: Center(
        child: Text(
          "CTF PROJECTS",
          style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 10,
            color: kTextColor.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
