import 'package:flutter/material.dart';
import '../components/backbuttonwithcolor.dart';
import 'home_body.dart';
import 'add_page.dart';
import '../../constants.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _selectedIndex = 2;

  static const List<Widget> _homeTabs = [
    StudentHomeBody(),
    StudentHomeBody(),
    AddPage(),
    StudentHomeBody(),
    StudentHomeBody(),
  ];

  void _tabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: AppBar(
          toolbarHeight: size.height * 0.1,
          elevation: 0,
          //automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
        ),
      ),
      body: Container(
        height: size.height * 0.724,
        width: size.width,
        decoration: const BoxDecoration(
            //color: Color.fromRGBO(30, 30, 30, 1),
            ),
        child: _homeTabs.elementAt(_selectedIndex),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: kPrimaryColor,
      //   foregroundColor: kBackgroundColor,
      //   icon: const Icon(
      //     Icons.add_box_rounded,
      //   ),
      //   label: const Text(
      //     "Add",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //   ),
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      //   onPressed: () {},
      // ),
      bottomNavigationBar: SafeArea(
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
              height: size.height * 0.14,
              backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
              surfaceTintColor: kTextColor,
              indicatorColor: kPrimaryColor,
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
                  size: 32,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: const Icon(
                  Icons.manage_search_rounded,
                  size: 25,
                ),
                icon: Icon(
                  Icons.manage_search_outlined,
                  color: kTextColor.withOpacity(0.4),
                  size: 32,
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
                  size: 32,
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
                  size: 32,
                ),
                label: 'Saved',
              ),
              NavigationDestination(
                selectedIcon: const Icon(
                  Icons.account_circle,
                  size: 25,
                ),
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: kTextColor.withOpacity(0.4),
                  size: 32,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
