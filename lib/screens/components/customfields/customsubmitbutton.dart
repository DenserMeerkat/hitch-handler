import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';

class CustomSubmitButton extends StatelessWidget {
  final Color bgcolor;
  final Size size;
  final String msg;
  final double? fsize;
  final double width;
  final Function()? press;
  final bool? isEnabled;
  const CustomSubmitButton({
    super.key,
    required this.size,
    required this.bgcolor,
    required this.msg,
    this.fsize = 18.0,
    this.width = 0.2,
    required this.press,
    this.isEnabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              color: kBlack15,
            )
          ]),
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return kGrey40;
            } else {
              return bgcolor.withOpacity(0.8);
            }
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return kGrey90;
            } else {
              return kBlack10;
            }
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            return kBlack10;
          }),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return kTextColor.withOpacity(0.3);
            }
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            );
          }),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(
                width: 2,
                color: kGrey30,
              );
            } else {
              return BorderSide(
                width: 2,
                color: bgcolor,
              );
            }
          }),
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.symmetric(
              vertical: 12,
              horizontal: size.width * width,
            );
          }),
        ),
        child: FittedBox(
          child: Text(
            msg,
            style: TextStyle(
              fontSize: fsize,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
