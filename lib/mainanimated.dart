// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/student_login/student_login.dart';
import 'screens/login/authority_login/authority_login.dart';

void main() {
  runApp(const MyApp());
}
class _SomeWidgetState extends State<_SomeWidget>
   with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 @override
  Future<void> initState() async {
    super.initState();
      _controller = AnimationController(
        duration:Duration(seconds: 3),
        vsync: this,
        home: HomeScreen(
        body:center(
          ListTile(
            leading: LoadingAnimationWidget.inkDrop(
            color: Color.fromARGB(255, 26, 153, 68),
            size: 50,
            ),
          )
        ),
      );
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key})


  

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hitch Handler',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      home: HomeScreen(),
    );
  }
}