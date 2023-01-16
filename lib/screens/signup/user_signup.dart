import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  int? stackIndex = 0;
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
              Navigator.of(context).pop(context);
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
                    child:
                        // CustomSlidingSegmentedControl<int>(
                        //   initialValue: 0,
                        //   children: {
                        //     0: Text(
                        //       'Student',
                        //       style: TextStyle(
                        //         color: stackIndex == 0
                        //             ? kBackgroundColor
                        //             : kTextColor.withOpacity(0.8),
                        //         fontWeight: FontWeight.bold,
                        //         letterSpacing: 0.5,
                        //         fontSize: 13,
                        //       ),
                        //     ),
                        //     1: Text(
                        //       'Staff',
                        //       style: TextStyle(
                        //         color: stackIndex == 1
                        //             ? kBackgroundColor
                        //             : kTextColor.withOpacity(0.8),
                        //         fontWeight: FontWeight.bold,
                        //         letterSpacing: 0.3,
                        //         fontSize: 13,
                        //       ),
                        //     ),
                        //   },
                        //   fixedWidth: size.width * 0.25,
                        //   isStretch: false,
                        //   decoration: BoxDecoration(
                        //     color: kBackgroundColor,
                        //     borderRadius: BorderRadius.circular(30.0),
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         color: kBlack10,
                        //         offset: Offset(1, 1),
                        //       )
                        //     ],
                        //   ),
                        //   thumbDecoration: BoxDecoration(
                        //     color: kPrimaryColor.withOpacity(0.9),
                        //     border: Border.all(
                        //       color: kPrimaryColor,
                        //       width: 2.0,
                        //     ),
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        //   duration: const Duration(milliseconds: 400),
                        //   curve: Curves.easeInOutCubic,
                        //   onValueChanged: (v) {
                        //     setState(() {
                        //       stackIndex = v;
                        //     });
                        //   },
                        // ),
                        Container(
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
              child:
                  // IndexedStack(
                  //   index: stackIndex,
                  //   children: [
                  //     Container(
                  //       height: size.height * 0.6,
                  //       child: SignupBody(
                  //         formwidget: StudentSignupForm(
                  //           fgcolor: arguments.fgcolor,
                  //           title: arguments.title,
                  //           icon: arguments.icon,
                  //           homeroute: UserSignUpScreen.routeName,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: size.height * 0.6,
                  //       child: SignupBody(
                  //         formwidget: StudentSignupForm(
                  //           fgcolor: kAuthorityColor,
                  //           title: arguments.title,
                  //           icon: arguments.icon,
                  //           homeroute: UserSignUpScreen.routeName,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(
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
                  Container(
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
                Navigator.of(context).pop(context);
              }, //Todo_navigation
            ),
          ),
        ),
      ),
    );
  }
}
