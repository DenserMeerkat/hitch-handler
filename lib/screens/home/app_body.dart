import 'package:flutter/material.dart';
import "../../constants.dart";

class StudentHomeBody extends StatelessWidget {
  const StudentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 1,

      //color: const Color.fromRGBO(30, 30, 30, 1),
    );
  }
}
