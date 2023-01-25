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
              Navigator.pushReplacementNamed(
                  context, StudentLoginScreen.routeName,
                  arguments: LoginSignUpArguments(
                    "StudentHero",
                    kStudentColor,
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
              backgroundColor: kGrey30,
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
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: kBlack10,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: kBlack15,
                          child: TabBar(
                            dividerColor: kBlack20,
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
                                color: kPrimaryColor.withOpacity(0.9),
                                border: Border.all(
                                  color: kPrimaryColor,
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
