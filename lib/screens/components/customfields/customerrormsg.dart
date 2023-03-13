import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

class CustomErrorMsg extends StatelessWidget {
  const CustomErrorMsg({
    super.key,
    required this.errorText,
    this.errorColor = kErrorColor,
    this.errorIcon = Icons.error,
    this.padTop = 5.0,
    this.padBottom = 10.0,
    this.padLeft = 30.0,
    this.padRight = 0.0,
    this.fsize = 15,
  });

  final String errorText;
  final Color errorColor;
  final IconData errorIcon;
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
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
