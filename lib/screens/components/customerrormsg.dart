import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomErrorMsg extends StatelessWidget {
  const CustomErrorMsg({
    super.key,
    required this.errorText,
    this.errorColor = kErrorColor,
    this.errorIcon = Icons.error,
    this.padBottom = 10.0,
    this.padLeft = 30.0,
    this.fsize = 15,
  });

  final String errorText;
  final Color errorColor;
  final IconData errorIcon;
  final double padBottom;
  final double padLeft;
  final double? fsize;

  Widget errorIconGen() {
    if (errorText != "") {
      return Icon(
        errorIcon,
        color: errorColor,
        size: fsize,
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
            padding:
                EdgeInsets.only(top: 5.0, bottom: padBottom, left: padLeft),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                errorIconGen(),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  errorText,
                  style: TextStyle(
                      color: errorColor,
                      letterSpacing: 0.4,
                      fontSize: fsize! - 3.0),
                )
              ],
            )) //CustomErrorMsg(),
        );
  }
}
