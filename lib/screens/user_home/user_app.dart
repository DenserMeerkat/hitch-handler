import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/user_home/add/addform.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/utils/customdialog.dart';
import '../components/appbar.dart';
import 'archives_page.dart';
import 'home_page.dart';
import 'add_page.dart';
import '../../constants.dart';
import '../../models/user.dart' as model;

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
    HomePage(),
    //AddPage(),
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
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    model.User? user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        endDrawer: Drawer(
          width: 280,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
          surfaceTintColor: isDark ? kBackgroundColor : kLBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(20)),
                  color: isDark ? kBlack20 : kLGrey50,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Future.delayed(
                      const Duration(seconds: 0),
                      () => showToggleThemeDialog(context),
                    );
                  },
                  icon: Icon(Icons.palette_outlined),
                ),
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(
                  user.email,
                  style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(
                  user.rollno,
                  style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                splashColor: isDark ? kGrey50 : kLGrey50,
                focusColor: isDark ? kGrey50 : kLGrey50,
                tileColor: isDark ? kGrey30 : kLGrey30,
                title: Text(
                  user.mobno,
                  style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        drawerEdgeDragWidth: size.width * 0.25,
        backgroundColor: isDark ? kBackgroundColor : kLBlack20,
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
                    child: SizedBox(
                      height: double.infinity,
                      width: 50,
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

                  // NavigationDestination(
                  //   selectedIcon: const Icon(
                  //     Icons.add_box_rounded,
                  //     color: kBackgroundColor,
                  //     size: 25,
                  //   ),
                  //   icon:
                  // Icon(
                  //     Icons.add_box_outlined,
                  //     color: isDark
                  //         ? kTextColor.withOpacity(0.4)
                  //         : kLTextColor.withOpacity(0.6),
                  //     size: 28,
                  //   ),
                  //   label: 'Add',
                  // ),
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
            ).animate(animation),
            child: child,
          );

          return transition;
        },
      ),
    );
  }
}
