import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/auth_home/auth_app.dart';
import 'package:hitch_handler/screens/user_home/user_app.dart';
import 'package:hitch_handler/themes.dart';
import 'package:hitch_handler/widget_tree.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'constants.dart';
import 'screens/launch/launch_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: isDark ? kBackgroundColor : kLBackgroundColor,
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
    systemNavigationBarDividerColor:
        isDark ? kBackgroundColor : kLBackgroundColor,
    statusBarColor: isDark ? kBackgroundColor : kLBackgroundColor,
    statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? WidgetTree.routeName : LaunchScreen.routeName,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(360, 678.3),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1),
              child: AdaptiveTheme(
                light: ThemeProvider.lightTheme,
                dark: ThemeProvider.darkTheme,
                initial: widget.savedThemeMode ?? AdaptiveThemeMode.dark,
                builder: (theme, darkTheme) => MaterialApp(
                  //showPerformanceOverlay: true,
                  debugShowCheckedModeBanner: false,
                  title: 'Hitch Handler',
                  navigatorKey: _navigatorKey,
                  theme: ThemeProvider.lightTheme,
                  darkTheme: ThemeProvider.darkTheme,
                  themeMode: ThemeMode.system,

                  initialRoute: FirebaseAuth.instance.currentUser == null
                      ? LaunchScreen.routeName
                      : WidgetTree.routeName,
                  routes: routes,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
