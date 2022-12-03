import 'package:flutter/material.dart';
import 'custompasswordfield.dart';
import '../../constants.dart';

class CustomConfirmPasswordField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  Function(String) onSubmit;
  CustomConfirmPasswordField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Password",
    required this.onSubmit,
  });

  @override
  State<CustomConfirmPasswordField> createState() =>
      _CustomConfirmPasswordFieldState(
          this.fgcolor, this.hinttext, this.onSubmit);
}

class _CustomConfirmPasswordFieldState
    extends State<CustomConfirmPasswordField> {
  final Color fgcolor;
  final String hinttext;
  Function(String) onSubmit;
  _CustomConfirmPasswordFieldState(this.fgcolor, this.hinttext, this.onSubmit);
  bool _obscureText = true;
  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPasswordField(fgcolor: fgcolor, onSubmit: (value) {}),
        SizedBox(
          height: size.height * 0.015,
        ),
        CustomPasswordField(fgcolor: fgcolor, onSubmit: (value) {}),
      ],
    );
  }
}
