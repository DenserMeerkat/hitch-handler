import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';
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

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
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
        child: MaterialApp(
          //showPerformanceOverlay: true,
          debugShowCheckedModeBanner: false,
          title: 'Hitch Handler',
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            accentColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          ),
          initialRoute: LaunchScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
