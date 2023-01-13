import 'package:flutter/material.dart';
import '../../constants.dart';

class LoginSignUpFooter extends StatelessWidget {
  const LoginSignUpFooter({
    Key? key,
    required this.size,
    required this.msg,
    required this.btntext,
    required this.fsize,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String msg;
  final String btntext;
  final double fsize;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: kBackgroundColor.withOpacity(0),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    msg,
                    style: TextStyle(
                      fontSize: fsize,
                      letterSpacing: 1,
                      color: kTextColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.001,
                    horizontal: size.width * 0.005),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white.withOpacity(0.1);
                      }
                      return null;
                    }),
                  ),
                  onPressed: press, //todo,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 2.0,
                        color: kTextColor.withOpacity(0.7),
                      ),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          btntext,
                          style: const TextStyle(
                            color: kTextColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
