// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customelevatedbutton.dart';
import '../login/student_login/student_login.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.05,
      right: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: size.height * 0.45,
          bottom: size.height * 0.025,
          left: size.width * 0.18,
          right: size.width * 0.18,
        ),
        height: size.height * 0.79,
        decoration: BoxDecoration(
          color: Color.fromRGBO(30, 30, 30, 1),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
            top: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 5,
              color: Color.fromRGBO(10, 10, 10, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomElevatedButtonWithIcon(
              bgcolor: Color.fromRGBO(20, 20, 20, 1),
              fgcolor: kStudentColor,
              shcolor: Color.fromRGBO(10, 10, 10, 1),
              bradius: 40.0,
              fsize: 16.0,
              title: "Student",
              press: () {},
              icon: Icons.school,
            ),
            CustomElevatedButtonWithIcon(
              bgcolor: Color.fromRGBO(20, 20, 20, 1),
              fgcolor: kAuthorityColor,
              shcolor: Color.fromRGBO(10, 10, 10, 1),
              bradius: 40.0,
              fsize: 16.0,
              title: "Authority",
              press: () {},
              icon: Icons.work,
            ),
            CustomElevatedButtonWithIcon(
              bgcolor: Color.fromRGBO(20, 20, 20, 1),
              fgcolor: kAdminColor,
              shcolor: Color.fromRGBO(10, 10, 10, 1),
              bradius: 40.0,
              fsize: 16.0,
              title: "Admin",
              press: () {},
              icon: Icons.key,
            ),
          ],
        ),
      ),
    );
  }
}
