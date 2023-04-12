import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/auth_home/auth_Archives_page.dart';
import 'package:hitch_handler/screens/auth_home/auth_home_page.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/appbar.dart';
import '../../constants.dart';

class AuthAppScreen extends StatefulWidget {
  static String routeName = '/app_screen';
  const AuthAppScreen({super.key});

  @override
  State<AuthAppScreen> createState() => _AuthAppScreenState();
}

class _AuthAppScreenState extends State<AuthAppScreen> {
  int _selectedIndex = 0;
  String email = "";
  String rollno = "";
  String mobno = "";
  static const List<Widget> _homeTabs = [
    AuthHomePage(),
    AuthArchivesPage(),
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
