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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 300,
      width: size.width * 0.95,
      padding: EdgeInsets.only(
        top: 20,
        right: size.width * 0.10,
        left: size.width * 0.10,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: isDark ? kGrey30 : kLGrey30,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30.0),
          top: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2.5),
            color: isDark ? kBlack15 : kGrey150,
          ),
          BoxShadow(
            offset: const Offset(0, -5),
            color: isDark ? kPrimaryColor : kLPrimaryColor,
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
                bgcolor: isDark ? kBackgroundColor : kLBackgroundColor,
                iconcolor: isDark ? kBlack20 : kBlack20,
                fgcolor: isDark ? kStudentColor : kLStudentColor,
                shcolor: isDark ? kBlack10 : kLGrey50,
                textcolor: isDark ? kStudentColor : kBlack20,
                bradius: 40.0,
                fsize: 15.0,
                title: "Student / Staff",
                icon: Icons.school,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "StudentHero",
                    isDark ? kStudentColor : kLStudentColor,
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
          const SizedBox(
            height: 25,
          ),
          Hero(
            tag: "AuthorityHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: isDark ? kBackgroundColor : kLBackgroundColor,
                iconcolor: kBlack20,
                fgcolor: isDark ? kAuthorityColor : kLAuthorityColor,
                shcolor: isDark ? kBlack10 : kLGrey50,
                textcolor: isDark ? kAuthorityColor : kBlack20,
                bradius: 40.0,
                fsize: 16.0,
                title: "Authority",
                icon: Icons.work,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AuthorityHero",
                    isDark ? kAuthorityColor : kLAuthorityColor,
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
          const SizedBox(
            height: 25,
          ),
          Hero(
            tag: "AdminHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: isDark ? kBackgroundColor : kLBackgroundColor,
                iconcolor: kBlack20,
                fgcolor: isDark ? kAdminColor : kLAdminColor,
                shcolor: isDark ? kBlack10 : kLGrey50,
                textcolor: isDark ? kAdminColor : kBlack20,
                bradius: 40.0,
                fsize: 16.0,
                title: "Admin",
                icon: Icons.key,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AdminHero",
                    isDark ? kAdminColor : kLAdminColor,
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
