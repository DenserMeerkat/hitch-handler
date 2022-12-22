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
      height: size.height * 0.44,
      width: size.width * 0.95,
      padding: EdgeInsets.only(
        top: size.width * 0.13,
        right: size.width * 0.10,
        left: size.width * 0.10,
        bottom: size.width * 0.08,
      ),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.0),
          top: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            color: Color.fromRGBO(15, 15, 15, 1),
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
                bgcolor: const Color.fromRGBO(20, 20, 20, 1),
                fgcolor: kStudentColor,
                shcolor: const Color.fromRGBO(10, 10, 10, 1),
                bradius: 40.0,
                fsize: 15.0,
                title: "Student / Staff",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const StudentLoginScreen(
                        herotag: "StudentHero",
                        fgcolor: kStudentColor,
                        title: "Student / Staff",
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
            height: size.height * 0.035,
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
            height: size.height * 0.035,
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
