import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/user_home/main_app.dart';
import 'package:hitch_handler/themes.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? AppScreen.routeName : LaunchScreen.routeName,
      );
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          )
        ],
        child: MaterialApp(
          //showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          title: 'Hitch Handler',
          navigatorKey: _navigatorKey,
          theme: Styles.lightTheme,
          darkTheme: Styles.darkTheme,
          themeMode: ThemeMode.system,

          initialRoute: FirebaseAuth.instance.currentUser == null
              ? LaunchScreen.routeName
              : AppScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
