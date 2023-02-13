import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/login/student_login.dart';
import '../../constants.dart';
import '../components/customsigninappbar.dart';
import '../components/loginsignupfooter.dart';
import '../../args_class.dart';
import 'signupbody.dart';
import 'studentsignupform.dart';

class UserSignUpScreen extends StatefulWidget {
  static String routeName = '/student_signup';
  const UserSignUpScreen({
    super.key,
  });
  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final arguments =
        ModalRoute.of(context)?.settings.arguments as LoginSignUpArguments;
    Size size = MediaQuery.of(context).size; // Available screen size

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushReplacementNamed(context, StudentLoginScreen.routeName,
            arguments: LoginSignUpArguments(
              "StudentHero",
              isDark ? kStudentColor : kLStudentColor,
              "Student / Staff",
              Icons.school,
            ));
        return true;
      },
      child: Scaffold(
        backgroundColor: isDark ? kGrey30 : kLGrey30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kHeaderHeight,
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          elevation: 0,
          flexibleSpace: CustomSignInAppBar(
            herotag: arguments.herotag,
            size: size,
            fgcolor: arguments.fgcolor,
            title: arguments.title,
            icon: arguments.icon,
            press: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pushReplacementNamed(
                  context, StudentLoginScreen.routeName,
                  arguments: LoginSignUpArguments(
                    "StudentHero",
                    isDark ? kStudentColor : kLStudentColor,
                    "Student / Staff",
                    Icons.school,
                  ));
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              surfaceTintColor: isDark ? Colors.white10 : Colors.black12,
              backgroundColor: isDark ? kGrey30 : kLGrey30,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: size.width * 0.25,
                    right: size.width * 0.25,
                    bottom: 15.0,
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: isDark ? kBlack10 : kGrey50,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: isDark ? kBlack15 : kGrey30,
                          child: TabBar(
                            dividerColor: isDark ? kBlack15 : kGrey30,
                            indicatorWeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: kBlack10,
                            unselectedLabelColor: kTextColor.withOpacity(0.8),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                            splashBorderRadius: BorderRadius.circular(50),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: isDark
                                    ? kPrimaryColor.withOpacity(0.9)
                                    : kLPrimaryColor.withOpacity(0.9),
                                border: Border.all(
                                  color:
                                      isDark ? kPrimaryColor : kLPrimaryColor,
                                  width: 2,
                                )),
                            controller: _tabController,
                            tabs: const <Widget>[
                              Tab(
                                text: "Student",
                              ),
                              Tab(
                                text: "Staff",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.6,
                    child: SignupBody(
                      formwidget: StudentSignupForm(
                        fgcolor: arguments.fgcolor,
                        title: arguments.title,
                        icon: arguments.icon,
                        homeroute: UserSignUpScreen.routeName,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                    child: SignupBody(
                      formwidget: StudentSignupForm(
                        fgcolor: kAuthorityColor,
                        title: arguments.title,
                        icon: arguments.icon,
                        homeroute: UserSignUpScreen.routeName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? kBackgroundColor : kLBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -2),
                color: isDark ? kBlack15 : kLGrey50,
              ),
            ],
          ),
          height: 70,
          child: Center(
            child: LoginSignUpFooter(
              size: size,
              msg: "Already have an account ?",
              btntext: "Login",
              fsize: 15,
              press: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                Navigator.pushReplacementNamed(
                    context, StudentLoginScreen.routeName,
                    arguments: LoginSignUpArguments(
                      "StudentHero",
                      kStudentColor,
                      "Student / Staff",
                      Icons.school,
                    ));
              }, //Todo_navigation
            ),
          ),
        ),
      ),
    );
  }
}
