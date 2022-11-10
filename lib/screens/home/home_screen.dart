// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/popupmenu.dart';
import 'package:hitch_handler/screens/home/body_(home_screen).dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        foregroundColor: kTextColor.withOpacity(0.5),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {}, //Todo
              child: Icon(
                Icons.info_outline,
              ),
            ),
          ),
          PopupMenu(),
          SizedBox(
            width: kDefaultPadding / 2,
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}
