import 'package:flutter/material.dart';
import '../../constants.dart';

class BackButtonWithColor extends StatelessWidget {
  const BackButtonWithColor({
    Key? key,
    required this.shcolor,
    required this.press,
    required this.bgcolor,
    required this.iconbg,
  }) : super(key: key);

  final Color shcolor;
  final Function()? press;
  final Color bgcolor;
  final Color iconbg;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: iconbg.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: shcolor,
              ),
            ],
            border: Border.all(
              width: 2.0,
              color: iconbg,
            )),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            splashRadius: 50.0,
            splashColor: Colors.white.withOpacity(0.2),
            onPressed: press,
            icon: Icon(
              Icons.arrow_back,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 5,
                  color: bgcolor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ));
  }
}
