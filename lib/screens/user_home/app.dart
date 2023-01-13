import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/launch/launch_screen.dart';
import 'home_page.dart';
import 'app_body.dart';
import 'add_page.dart';
import '../../constants.dart';

class AppScreen extends StatefulWidget {
  static String routeName = '/app_screen';
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _homeTabs = [
    HomePage(),
    AddPage(),
    HomePage(),
  ];

  void _tabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                tileColor: kGrey30,
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
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
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              splashRadius: 20.0,
              //splashColor: Colors.transparent,
              icon: const Icon(
                Icons.logout_rounded,
                color: kTextColor,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
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
                height: size.height * 0.1,
                backgroundColor: kBackgroundColor,
                surfaceTintColor: kTextColor,
                indicatorColor: kPrimaryColor,
                elevation: 5,
                labelTextStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    );
                  } else {
                    return TextStyle(
                      color: kTextColor.withOpacity(0.6),
                    );
                  }
                })),
            child: NavigationBar(
              shadowColor: Colors.black,
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
                // NavigationDestination(
                //   selectedIcon: const Icon(
                //     Icons.manage_search_rounded,
                //     size: 25,
                //   ),
                //   icon: Icon(
                //     Icons.manage_search_outlined,
                //     color: kTextColor.withOpacity(0.4),
                //     size: 32,
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
                // NavigationDestination(
                //   selectedIcon: const Icon(
                //     Icons.account_circle,
                //     size: 25,
                //   ),
                //   icon: Icon(
                //     Icons.account_circle_outlined,
                //     color: kTextColor.withOpacity(0.4),
                //     size: 32,
                //   ),
                //   label: 'Profile',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
