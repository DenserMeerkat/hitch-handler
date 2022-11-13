// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customelevatedbutton.dart';
import '../login/admin_login/admin_login.dart';
import '../login/student_login/student_login.dart';
import '../login/authority_login/authority_login.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      padding: EdgeInsets.only(
          left: size.width * 0.14,
          right: size.width * 0.14,
          top: size.height * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButtonWithIcon(
            bgcolor: Color.fromRGBO(20, 20, 20, 1),
            fgcolor: kStudentColor,
            shcolor: Color.fromRGBO(10, 10, 10, 1),
            bradius: 40.0,
            fsize: 14.0,
            title: "Student / Staff",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return StudentLoginScreen();
                }),
              );
              print("Done");
            },
            icon: Icons.school,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          CustomElevatedButtonWithIcon(
            bgcolor: Color.fromRGBO(20, 20, 20, 1),
            fgcolor: kAuthorityColor,
            shcolor: Color.fromRGBO(10, 10, 10, 1),
            bradius: 40.0,
            fsize: 16.0,
            title: "Authority",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AuthorityLoginScreen();
                }),
              );
            },
            icon: Icons.work,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          CustomElevatedButtonWithIcon(
            bgcolor: Color.fromRGBO(20, 20, 20, 1),
            fgcolor: kAdminColor,
            shcolor: Color.fromRGBO(10, 10, 10, 1),
            bradius: 40.0,
            fsize: 16.0,
            title: "Admin",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AdminLoginScreen();
                }),
              );
            },
            icon: Icons.key,
          ),
        ],
      ),
    );
  }
}
