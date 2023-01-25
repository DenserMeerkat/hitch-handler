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
    model.User user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: kBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: kGrey50,
                ),
                child: Text(''),
              ),
              ListTile(
                tileColor: kGrey30,
                title: Text(user.email),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                tileColor: kGrey30,
                title: Text(user.rollno),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                tileColor: kGrey30,
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
        backgroundColor: kBackgroundColor,
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
          color: kGrey30,
          child: SafeArea(
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                  height: 70,
                  shadowColor: kBlack10,
                  backgroundColor: kBackgroundColor,
                  surfaceTintColor: kBackgroundColor,
                  indicatorColor: kPrimaryColor,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  labelTextStyle: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      );
                    } else {
                      return TextStyle(
                        fontSize: 12,
                        color: kTextColor.withOpacity(0.6),
                      );
                    }
                  })),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                animationDuration: const Duration(milliseconds: 500),
                onDestinationSelected: (value) {
                  return _tabChange(value);
                },
                destinations: [
                  NavigationDestination(
                    selectedIcon: const Icon(
                      Icons.home_rounded,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.home_outlined,
                      color: kTextColor.withOpacity(0.4),
                      size: 28,
                    ),
                    label: 'Home',
                  ),
                  // NavigationDestination(
                  //   selectedIcon: const Icon(
                  //     Icons.pageview_rounded,
                  //     size: 28,
                  //   ),
                  //   icon: Icon(
                  //     Icons.pageview_outlined,
                  //     color: kTextColor.withOpacity(0.4),
                  //     size: 30,
                  //   ),
                  //   label: 'Search',
                  // ),
                  NavigationDestination(
                    selectedIcon: const Icon(
                      Icons.add_box_rounded,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: kTextColor.withOpacity(0.4),
                      size: 28,
                    ),
                    label: 'Add',
                  ),
                  NavigationDestination(
                    selectedIcon: const Icon(
                      Icons.archive_rounded,
                      size: 25,
                    ),
                    icon: Icon(
                      Icons.archive_outlined,
                      color: kTextColor.withOpacity(0.4),
                      size: 28,
                    ),
                    label: 'Archives',
                  ),
                  // NavigationDestination(
                  //   selectedIcon: const Icon(
                  //     Icons.account_box,
                  //     size: 28,
                  //   ),
                  //   icon: Icon(
                  //     Icons.account_box_outlined,
                  //     color: kTextColor.withOpacity(0.4),
                  //     size: 30,
                  //   ),
                  //   label: 'Profile',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
