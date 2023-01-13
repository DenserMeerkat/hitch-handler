import 'package:flutter/material.dart';
import '../../../constants.dart';

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
      child: SizedBox(
        height: kDefaultPadding * 2.6,
        width: kDefaultPadding * 12.5,
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
                        offset: const Offset(1, 0),
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
                    padding: const EdgeInsets.only(right: kDefaultPadding),
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
