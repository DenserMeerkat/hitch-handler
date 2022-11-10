// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.bgcolor,
    this.fgcolor,
    this.shcolor,
    required this.bradius,
    required this.fsize,
    required this.title,
    required this.press,
    this.padding = kDefaultPadding,
  }) : super(key: key);
  final Color bgcolor;
  final Color? fgcolor;
  final Color? shcolor;
  final double bradius;
  final double fsize;
  final double padding;
  final String title;
  final Function()? press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return bgcolor.withOpacity(0.9);
          }
          return bgcolor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return fgcolor;
        }),
        shadowColor: MaterialStateProperty.resolveWith((states) {
          return shcolor;
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bradius),
          );
        }),
        padding: MaterialStateProperty.resolveWith((states) {
          return EdgeInsets.symmetric(
            vertical: padding / 1.25,
            horizontal: padding * 2,
          );
        }),
      ),
      onPressed: press,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fsize,
        ),
      ),
    );
  }
}

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    Key? key,
    required this.bgcolor,
    required this.fgcolor,
    required this.shcolor,
    required this.bradius,
    required this.fsize,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);
  final Color bgcolor;
  final Color fgcolor;
  final Color shcolor;
  final double bradius;
  final double fsize;
  final String title;
  final Function()? press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(bradius),
        boxShadow: [
          BoxShadow(
            color: shcolor,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: SizedBox(
        height: kDefaultPadding * 2.6,
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                Container(
                  height: kDefaultPadding * 2.6,
                  width: kDefaultPadding * 4,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: fgcolor.withOpacity(0.9),
                    border: Border.all(
                      width: 3.0,
                      color: fgcolor,
                    ),
                    borderRadius: BorderRadius.circular(bradius),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 0),
                        color: shcolor,
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: bgcolor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: kDefaultPadding),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontSize: fsize,
                        color: fgcolor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {}, //Todo
                borderRadius: BorderRadius.circular(bradius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
