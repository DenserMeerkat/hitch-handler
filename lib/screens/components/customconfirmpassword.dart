import 'package:flutter/material.dart';
import '../../string_extensions.dart';
import 'customerrormsg.dart';
import 'custompasswordfield.dart';
import '../../constants.dart';

class CustomConfirmPasswordField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  TextEditingController controller;
  CustomConfirmPasswordField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Password",
    required this.controller,
  });

  @override
  State<CustomConfirmPasswordField> createState() =>
      _CustomConfirmPasswordFieldState(fgcolor, hinttext, controller);
}

class _CustomConfirmPasswordFieldState
    extends State<CustomConfirmPasswordField> {
  final Color fgcolor;
  final String hinttext;
  TextEditingController controller;
  _CustomConfirmPasswordFieldState(
      this.fgcolor, this.hinttext, this.controller);
  IconData errorIcon = Icons.error;
  Color errorColor = kWarnColor;
  late String errorText = "One or more Fields empty";
  late IconData iconData = Icons.warning;

  late String password = '';
  late String confirmPassword = '';
  void checkPass() {
    if (!password.isWhitespace() && !confirmPassword.isWhitespace()) {
      if (password.isValidPassword()) {
        if (password == confirmPassword) {
          setState(() {
            errorText = "Passwords Match";
            errorColor = kValidColor;
            iconData = Icons.check_circle;
            controller.text = password;
          });
        } else {
          setState(() {
            errorText = "Passwords don't Match";
            errorColor = kErrorColor;
            iconData = Icons.unpublished;
          });
        }
      } else {
        setState(() {
          errorText = "Not a valid Password!";
          errorColor = kErrorColor;
          iconData = Icons.error;
        });
      }
    } else if (!password.isValidPassword()) {
      setState(() {
        errorText = "Not a valid Password!";
        errorColor = kErrorColor;
        iconData = Icons.error;
      });
    } else {
      setState(() {
        errorText = 'One or more Fields empty';
        errorColor = kWarnColor;
        iconData = Icons.warning;
      });
    }
  }

  final myPassFieldController = TextEditingController();
  final myConfPassFieldController = TextEditingController();
  @override
  void dispose() {
    myPassFieldController.dispose();
    myConfPassFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPasswordField(
          controller: myPassFieldController,
          extraError: true,
          showError: false,
          hinttext: hinttext,
          fgcolor: fgcolor,
          onSubmit: (value) {
            setState(() {
              password = value;
            });
            checkPass();
          },
          onChange: (value) {
            setState(() {
              password = value;
            });
            checkPass();
          },
        ),
        // const SizedBox(
        //   height: 10.0,
        // ),
        CustomPasswordField(
          controller: myConfPassFieldController,
          extraError: false,
          showError: false,
          hinttext: "Confirm Password",
          fgcolor: fgcolor,
          onSubmit: (value) {
            setState(() {
              confirmPassword = value;
            });
            checkPass();
          },
          onChange: (value) {
            setState(() {
              confirmPassword = value;
            });
            checkPass();
          },
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(20, 20, 20, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CustomErrorMsg(
              padLeft: 0,
              padBottom: 5,
              errorText: errorText,
              errorIcon: iconData,
              errorColor: errorColor,
              fsize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
