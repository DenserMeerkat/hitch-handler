import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:hitch_handler/screens/components/appbar.dart';
import 'package:hitch_handler/screens/user_home/archives_page.dart';
import 'package:hitch_handler/screens/user_home/home_page.dart';
import 'package:hitch_handler/screens/user_home/add_page.dart';
import 'package:hitch_handler/constants.dart';

class AppScreen extends StatefulWidget {
  static String routeName = '/app_screen';
  static final StreamController<List<DocumentSnapshot>> homeController1 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  static final StreamController<List<DocumentSnapshot>> homeController2 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  static final StreamController<List<DocumentSnapshot>> archiveController1 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  static final StreamController<List<DocumentSnapshot>> archiveController2 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;
  String email = "";
  String rollno = "";
  String mobno = "";
  static const List<Widget> _homeTabs = [
    HomePage(),
    SizedBox(),
    ArchivesPage(),
  ];
  final pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _tabChange(int index) {
    pageController.jumpToPage(index);
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: isDark ? kBackgroundColor : kLBlack20,
        appBar: const MainAppBar(),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          children: _homeTabs,
        ),
        //_homeTabs[_selectedIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 1),
          color: isDark ? kGrey30 : kLGrey30,
          child: SafeArea(
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                height: 70,
                shadowColor: kBlack10,
                backgroundColor: isDark ? kBackgroundColor : kLBlack20,
                surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
                indicatorColor: isDark ? kPrimaryColor : kLPrimaryColor,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                labelTextStyle: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? kTextColor : kLTextColor,
                      );
                    } else {
                      return TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? kTextColor.withOpacity(0.6)
                            : kLTextColor.withOpacity(0.6),
                      );
                    }
                  },
                ),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                animationDuration: const Duration(milliseconds: 500),
                onDestinationSelected: (value) {
                  return _tabChange(value);
                },
                destinations: [
                  NavigationDestination(
                    selectedIcon: const Icon(
                      color: kBackgroundColor,
                      Icons.home_rounded,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.home_outlined,
                      color: isDark
                          ? kTextColor.withOpacity(0.4)
                          : kLTextColor.withOpacity(0.6),
                      size: 28,
                    ),
                    label: 'Home',
                  ),
                  GestureDetector(
                    onTap: () {
                      pushAddPage(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        fit: StackFit.loose,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: 65,
                              height: 40,
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  pushAddPage(context);
                                },
                                child: Icon(
                                  Icons.add_box_outlined,
                                  color: isDark
                                      ? kTextColor.withOpacity(0.4)
                                      : kLTextColor.withOpacity(0.6),
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? kTextColor.withOpacity(0.6)
                                    : kLTextColor.withOpacity(0.6),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  NavigationDestination(
                    selectedIcon: const Icon(
                      Icons.archive_rounded,
                      color: kBackgroundColor,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.archive_outlined,
                      color: isDark
                          ? kTextColor.withOpacity(0.4)
                          : kLTextColor.withOpacity(0.6),
                      size: 28,
                    ),
                    label: 'Archives',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pushAddPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AddPage(),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          final Widget transition = SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.decelerate)).animate(animation),
            child: child,
          );

          return transition;
        },
      ),
    );
  }
}
