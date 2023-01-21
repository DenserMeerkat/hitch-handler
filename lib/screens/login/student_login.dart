import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/launch/launch_screen.dart';
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
          toolbarHeight: 140,
          backgroundColor: kBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            herotag: arguments.herotag,
            size: size,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            press: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pushReplacementNamed(context, LaunchScreen.routeName);
            },
          ),
        ),
        body: LoginBody(
          formwidget: LoginForm(
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            homeroute: StudentLoginScreen.routeName,
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
          height: 70,
          child: Center(
            child: LoginSignUpFooter(
              size: size,
              msg: "Don't have an account ?",
              btntext: "Sign Up",
              fsize: 16,
              press: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
