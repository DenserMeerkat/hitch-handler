import 'package:flutter/material.dart';
import '../../args_class.dart';
import 'loginform.dart';
import '../../constants.dart';
import '../components/loginsignupfooter.dart';
import '../components/customsigninappbar.dart';
import 'loginbody.dart';
import '../signup/user_signup.dart';

class StudentLoginScreen extends StatelessWidget {
  static String routeName = '/student_login';
  const StudentLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as LoginSignUpArguments;
    Size size = MediaQuery.of(context).size; // Available screen size
    return Theme(
      data: ThemeData(
        accentColor: kStudentColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      child: Scaffold(
        backgroundColor: kGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: size.height * 0.18,
          backgroundColor: kBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            herotag: arguments.herotag,
            size: size,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            press: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ),
        body: SizedBox(
          height: size.height * 0.67,
          width: size.height * 0.95,
          child: LoginBody(
            formwidget: LoginForm(
              fgcolor: arguments.fgcolor,
              title: arguments.title,
              icon: arguments.icon,
              homeroute: StudentLoginScreen.routeName,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                color: kBlack15,
              ),
            ],
          ),
          height: size.height * 0.1,
          child: Center(
            child: LoginSignUpFooter(
              size: size,
              msg: "Don't have an account ?",
              btntext: "Sign Up",
              fsize: 16,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                LoginSignUpArguments args = LoginSignUpArguments(
                  "",
                  arguments.fgcolor,
                  arguments.title,
                  arguments.icon,
                );

                Navigator.pushNamed(
                  context,
                  UserSignUpScreen.routeName,
                  arguments: args,
                );
              }, //Todo_Navigation
            ),
          ),
        ),
      ),
    );
  }
}
