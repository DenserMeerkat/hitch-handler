import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/user_home/main_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'constants.dart';
import 'screens/launch/launch_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kBackgroundColor,
      systemNavigationBarColor: kBackgroundColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OverlaySupport.global(
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
            theme: ThemeData(
              //useMaterial3: true,
              scaffoldBackgroundColor: kBackgroundColor,
              accentColor: kPrimaryColor,
              textTheme:
                  Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            ),

            initialRoute: FirebaseAuth.instance.currentUser == null
                ? LaunchScreen.routeName
                : AppScreen.routeName,
            routes: routes,
          ),
        ),
      ),
    );
  }
}
