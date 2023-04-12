import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorMsg extends StatelessWidget {
  final String errorText;
  final IconData errorIcon;
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
  final double? fsize;
  CustomErrorMsg({
    super.key,
    required this.errorText,
    this.errorIcon = Icons.error,
    this.padTop = 8.0,
    this.padBottom = 15.0,
    this.padLeft = 30.0,
    this.padRight = 0.0,
    this.fsize = 15,
  });

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

  late Color errorColor;

  @override
  Widget build(BuildContext context) {
    errorColor = AdaptiveTheme.of(context).theme.colorScheme.error;
    return Padding(
      padding: EdgeInsets.only(
        top: padTop.h,
        bottom: padBottom.h,
        left: padLeft.w,
        right: padRight.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 8,
          ),
          Text(
            errorText,
            style: TextStyle(
              height: 1,
              color: errorColor,
              letterSpacing: 0.4,
              fontSize: errorText != '' ? (fsize! - 3.0).sp : 0,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          errorIconGen(),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
