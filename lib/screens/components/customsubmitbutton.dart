import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.size,
    required this.bgcolor,
    required this.msg,
    this.fsize = 18.0,
    this.width = 0.2,
    required this.press,
  });
  final Color bgcolor;
  final Size size;
  final String msg;
  final double? fsize;
  final double width;
  final Function()? press;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              color: Color.fromRGBO(10, 10, 10, 1),
            )
          ]),
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Color.fromRGBO(30, 30, 30, 1);
            } else {
              return bgcolor.withOpacity(0.8);
            }
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            return const Color.fromRGBO(10, 10, 10, 1);
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            return const Color.fromRGBO(10, 10, 10, 1);
          }),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.3);
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
                color: Color.fromRGBO(30, 30, 30, 1),
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
              vertical: 15,
              horizontal: size.width * width,
            );
          }),
        ),
        child: Text(
          msg,
          style: TextStyle(
            fontSize: fsize,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
