import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../resources/auth_methods.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';
import '../launch/launch_screen.dart';
import 'appbar.dart';
import 'archives_page.dart';
import 'home_page.dart';
import 'add_page.dart';
import '../../constants.dart';
import '../../models/user.dart' as model;
import 'search_page.dart';

class AppScreen extends StatefulWidget {
  static String routeName = '/app_screen';
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
    //SearchPage(),
    AddPage(),
    BookmarkPage(),
    //SearchPage(),
  ];

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  void _tabChange(int index) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    model.User user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDark ? kGrey50 : kLGrey50,
                ),
                child: Text(''),
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(user.email),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(user.rollno),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(user.mobno),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        drawerEdgeDragWidth: size.width * 0.25,
        backgroundColor: isDark ? kBackgroundColor : kLGrey30,
        appBar: const MainAppBar(),
        body: Container(
          height: size.height * 0.9,
          width: size.width,
          decoration: const BoxDecoration(
              //color: kGrey30,
              ),
          child: _homeTabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 2),
          color: isDark ? kGrey30 : kLGrey30,
          child: SafeArea(
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                height: 70,
                shadowColor: kBlack10,
                backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
                surfaceTintColor: isDark ? kBackgroundColor : kLBackgroundColor,
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
                  NavigationDestination(
                    selectedIcon: const Icon(
                      Icons.add_box_rounded,
                      color: kBackgroundColor,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: isDark
                          ? kTextColor.withOpacity(0.4)
                          : kLTextColor.withOpacity(0.6),
                      size: 28,
                    ),
                    label: 'Add',
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
}
