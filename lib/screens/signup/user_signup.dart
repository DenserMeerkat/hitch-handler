import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:hitch_handler/screens/login/student_login.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';
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
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
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
          toolbarHeight: kHeaderHeight.h,
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
              surfaceTintColor: isDark ? kGrey30 : kLGrey30,
              backgroundColor: isDark ? kGrey30 : kLGrey30,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(
                    top: 12.0.h,
                    left: size.width * 0.25,
                    right: size.width * 0.25,
                    bottom: 14.0.h,
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: isDark ? kBlack10 : kLGrey70,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: isDark ? kBlack20 : kLBlack10,
                          child: TabBar(
                            dividerColor: isDark ? kBlack20 : kLBlack10,
                            indicatorWeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: kBlack10,
                            unselectedLabelColor: isDark
                                ? kTextColor.withOpacity(0.8)
                                : kLTextColor.withOpacity(0.8),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12.sp,
                              letterSpacing: 0.5,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              letterSpacing: 0.5,
                            ),
                            splashBorderRadius: BorderRadius.circular(50.r),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: kPrimaryColor.withOpacity(0.9),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2,
                              ),
                            ),
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
            SliverToBoxAdapter(
              child: loading ? const LProgressIndicator() : Container(),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  SizedBox(
                    child: SignupBody(
                      formwidget: NotificationListener<IsLoading>(
                        onNotification: (n) {
                          setState(() {
                            loading = n.isLoading;
                          });
                          return true;
                        },
                        child: StudentSignupForm(
                          fgcolor: arguments.fgcolor,
                          title: arguments.title,
                          icon: arguments.icon,
                          homeroute: UserSignUpScreen.routeName,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: SignupBody(
                      formwidget: NotificationListener<IsLoading>(
                        onNotification: (n) {
                          setState(() {
                            loading = n.isLoading;
                          });
                          return true;
                        },
                        child: StudentSignupForm(
                          fgcolor: kAuthorityColor,
                          title: arguments.title,
                          icon: arguments.icon,
                          homeroute: UserSignUpScreen.routeName,
                        ),
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
          height: 70.h,
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
