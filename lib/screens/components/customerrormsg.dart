import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomErrorMsg extends StatelessWidget {
  const CustomErrorMsg({
    super.key,
    required this.errorText,
    this.errorColor = kErrorColor,
    this.errorIcon = Icons.error,
    this.padbottom = 10.0,
  });

  final String errorText;
  final Color errorColor;
  final IconData errorIcon;
  final double padbottom;

  Widget errorIconGen() {
    if (errorText != "") {
      return Icon(
        errorIcon,
        color: errorColor,
        size: 15,
      );
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
        offstage: false,
        child: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: padbottom, left: 30.0),
            child: Row(
              children: [
                errorIconGen(),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  errorText,
                  style: TextStyle(
                      color: errorColor, letterSpacing: 0.4, fontSize: 12),
                )
              ],
            )) //CustomErrorMsg(),
        );
  }
}
