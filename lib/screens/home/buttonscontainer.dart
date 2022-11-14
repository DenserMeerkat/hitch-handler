import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customelevatedbutton.dart';
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
      height: size.height * 0.35,
      padding: EdgeInsets.only(
          left: size.width * 0.14,
          right: size.width * 0.14,
          top: size.height * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "StudentHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: const Color.fromRGBO(20, 20, 20, 1),
                fgcolor: kStudentColor,
                shcolor: const Color.fromRGBO(10, 10, 10, 1),
                bradius: 40.0,
                fsize: 14.0,
                title: "Student / Staff",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const StudentLoginScreen(
                        herotag: "StudentHero",
                        fgcolor: kStudentColor,
                        title: "Student/Staff",
                        icon: Icons.school,
                      );
                    }),
                  );
                },
                icon: Icons.school,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Hero(
            tag: "AuthorityHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: const Color.fromRGBO(20, 20, 20, 1),
                fgcolor: kAuthorityColor,
                shcolor: const Color.fromRGBO(10, 10, 10, 1),
                bradius: 40.0,
                fsize: 16.0,
                title: "Authority",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AuthorityLoginScreen(
                        herotag: "AuthorityHero",
                        fgcolor: kAuthorityColor,
                        title: "Authority",
                        icon: Icons.work,
                      );
                    }),
                  );
                },
                icon: Icons.work,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Hero(
            tag: "AdminHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: const Color.fromRGBO(20, 20, 20, 1),
                fgcolor: kAdminColor,
                shcolor: const Color.fromRGBO(10, 10, 10, 1),
                bradius: 40.0,
                fsize: 16.0,
                title: "Admin",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AdminLoginScreen(
                        fgcolor: kAdminColor,
                        title: "Admin",
                        icon: Icons.key,
                        herotag: "AdminHero",
                      );
                    }),
                  );
                },
                icon: Icons.key,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
