import 'package:flutter/material.dart';
import '../../args_class.dart';
import '../launch/launch_screen.dart';
import 'loginform.dart';
import '../../constants.dart';
import '../components/loginsignupfooter.dart';
import '../components/customsigninappbar.dart';
import 'loginbody.dart';

class AuthorityLoginScreen extends StatelessWidget {
  static String routeName = '/authority_login';
  const AuthorityLoginScreen({
    super.key,
  });
  @override
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as LoginSignUpArguments;
    Size size = MediaQuery.of(context).size; // Available screen size
    return Theme(
      data: ThemeData(
        accentColor: kAuthorityColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      child: Scaffold(
        backgroundColor: kGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          toolbarHeight: 140,
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
        body: SizedBox(
          height: size.height * 0.67,
          width: size.height * 0.95,
          child: LoginBody(
            formwidget: LoginForm(
              fgcolor: arguments.fgcolor,
              title: arguments.title,
              icon: arguments.icon,
              homeroute: AuthorityLoginScreen.routeName,
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
          height: 80,
          child: LoginSignUpFooter(
            size: size,
            msg: "Contact Support to register as an Admin.",
            btntext: "Support",
            fsize: 15,
            press: () {}, //Todo_Support
          ),
        ),
      ),
    );
  }
}
