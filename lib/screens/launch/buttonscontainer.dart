import 'package:flutter/material.dart';
import '../../args_class.dart';
import '../../constants.dart';
import '../components/customfields/customelevatedbutton.dart';
import '../login/admin_login.dart';
import '../login/student_login.dart';
import '../login/authority_login.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.44,
      width: size.width * 0.95,
      padding: EdgeInsets.only(
        top: size.width * 0.13,
        right: size.width * 0.10,
        left: size.width * 0.10,
        bottom: size.width * 0.08,
      ),
      decoration: const BoxDecoration(
        color: kGrey30,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.0),
          top: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            color: kBlack15,
          ),
          BoxShadow(
            offset: Offset(0, -5),
            color: kPrimaryColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "StudentHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: kBlack20,
                fgcolor: kStudentColor,
                shcolor: kBlack10,
                bradius: 40.0,
                fsize: 15.0,
                title: "Student / Staff",
                icon: Icons.school,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "StudentHero",
                    kStudentColor,
                    "Student / Staff",
                    Icons.school,
                  );
                  Navigator.pushNamed(
                    context,
                    StudentLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          Hero(
            tag: "AuthorityHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: kBlack20,
                fgcolor: kAuthorityColor,
                shcolor: kBlack10,
                bradius: 40.0,
                fsize: 16.0,
                title: "Authority",
                icon: Icons.work,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AuthorityHero",
                    kAuthorityColor,
                    "Authority",
                    Icons.work,
                  );

                  Navigator.pushNamed(
                    context,
                    AuthorityLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          Hero(
            tag: "AdminHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: kBlack20,
                fgcolor: kAdminColor,
                shcolor: kBlack10,
                bradius: 40.0,
                fsize: 16.0,
                title: "Admin",
                icon: Icons.key,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AdminHero",
                    kAdminColor,
                    "Admin",
                    Icons.key,
                  );

                  Navigator.pushNamed(
                    context,
                    AdminLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
