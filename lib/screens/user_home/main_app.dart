import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';
import '../launch/launch_screen.dart';
import 'bookmarks.dart';
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
    SearchPage(),
    AddPage(),
    SearchPage(),
    SearchPage(),
  ];

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
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
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "HITCH HANDLER",
            style: TextStyle(
              color: kTextColor.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                splashRadius: 20.0,
                icon: const Icon(
                  Icons.account_box_outlined,
                  color: kTextColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: "Account",
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              splashRadius: 20.0,
              //splashColor: Colors.transparent,
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: kTextColor,
              ),
              onPressed: () {
                showConfirmDialog(
                  context,
                  DialogCont(
                    title: "Logout",
                    message: "Are you sure you want to logout ?",
                    icon: Icons.exit_to_app_rounded,
                    iconBackgroundColor: kErrorColor.withOpacity(0.7),
                    primaryButtonLabel: "Logout",
                    primaryButtonColor: kGrey150,
                    secondaryButtonColor: kErrorColor.withOpacity(0.7),
                    primaryFunction: () async {
                      final navigator = Navigator.of(context);
                      final scaffold = ScaffoldMessenger.of(context);
                      await AuthMethods().signOut();
                      scaffold.removeCurrentSnackBar();
                      navigator.pushReplacementNamed(LaunchScreen.routeName);
                    },
                    secondaryFunction: () {
                      Navigator.pop(context);
                    },
                    borderRadius: 10,
                    //showSecondaryButton: false,
                  ),
                  borderRadius: 10,
                );
              },
              tooltip: "Logout",
            )
          ],
        ),
        body: Container(
          height: size.height * 0.9,
          width: size.width,
          decoration: const BoxDecoration(
              //color: kGrey30,
              ),
          child: _homeTabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SafeArea(
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
                height: 70,
                backgroundColor: kBackgroundColor,
                surfaceTintColor: kTextColor,
                indicatorColor: kPrimaryColor,
                elevation: 5,
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
              //shadowColor: Colors.black,
              selectedIndex: _selectedIndex,
              animationDuration: const Duration(milliseconds: 700),
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
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.pageview_rounded,
                    size: 28,
                  ),
                  icon: Icon(
                    Icons.pageview_outlined,
                    color: kTextColor.withOpacity(0.4),
                    size: 30,
                  ),
                  label: 'Search',
                ),
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
                    Icons.bookmark_rounded,
                    size: 25,
                  ),
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    color: kTextColor.withOpacity(0.4),
                    size: 28,
                  ),
                  label: 'Saved',
                ),
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.account_box,
                    size: 28,
                  ),
                  icon: Icon(
                    Icons.account_box_outlined,
                    color: kTextColor.withOpacity(0.4),
                    size: 30,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
