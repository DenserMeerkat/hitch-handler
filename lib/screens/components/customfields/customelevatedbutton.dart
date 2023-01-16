import 'package:flutter/material.dart';
import '../../../constants.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    Key? key,
    this.bgcolor = kBackgroundColor,
    required this.fgcolor,
    this.shcolor = kBlack20,
    this.bradius = 50,
    this.fsize = 14,
    required this.title,
    required this.press,
    required this.icon,
    this.height = kDefaultPadding * 2.4,
    this.width = kDefaultPadding * 12,
  }) : super(key: key);
  final Color bgcolor;
  final Color fgcolor;
  final Color shcolor;
  final double bradius;
  final double fsize;
  final String title;
  final Function()? press;
  final IconData icon;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(bradius),
        boxShadow: [
          BoxShadow(
            color: shcolor,
            offset: const Offset(1, 2),
          )
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
          maxWidth: width,
        ),
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                Container(
                  height: height,
                  width: width / 3 > 30 ? width / 3 : 30,
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
                        offset: const Offset(1, 0),
                        color: shcolor,
                      )
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Icon(
                          icon,
                          color: bgcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: fsize < 18 ? fsize : 18,
                      color: fgcolor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: kTextColor.withOpacity(0.1),
                focusColor: kTextColor.withOpacity(0.1),
                hoverColor: kTextColor.withOpacity(0.1),
                highlightColor: kTextColor.withOpacity(0.1),
                onTap: press,
                borderRadius: BorderRadius.circular(bradius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonWithIcon extends StatelessWidget {
  void Function()? onPressed;
  String label;
  IconData icon;
  Color activeColor;
  Color borderColor;
  double borderRadius;
  ElevatedButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.activeColor,
    this.borderColor = Colors.transparent,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kGrey30;
          }
          return activeColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return kTextColor.withOpacity(0.5);
          }
          return kBlack10;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 12,
          );
        }),
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
