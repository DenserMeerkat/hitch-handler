import 'package:flutter/material.dart';
import 'addform.dart';
import '../../constants.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Add Your Problem",
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 32,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "Explain you problem with details.",
            style: TextStyle(
              color: kTextColor.withOpacity(0.7),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: size.height * 0.075),
          const AddForm(),
        ],
      ),
    );
  }
}
