// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customfields/custompasswordfield.dart';
import 'package:hitch_handler/string_extensions.dart';

class CustomConfirmPasswordField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  final TextEditingController controller;
  const CustomConfirmPasswordField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Password",
    required this.controller,
  });

  @override
  State<CustomConfirmPasswordField> createState() =>
      _CustomConfirmPasswordFieldState();
}

class _CustomConfirmPasswordFieldState
    extends State<CustomConfirmPasswordField> {
  _CustomConfirmPasswordFieldState();
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
            widget.controller.text = password;
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
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPasswordField(
          controller: myPassFieldController,
          extraError: true,
          showError: false,
          hinttext: widget.hinttext,
          fgcolor: widget.fgcolor,
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
        SizedBox(
          height: 15.h,
        ),
        CustomPasswordField(
          controller: myConfPassFieldController,
          extraError: false,
          showError: false,
          hinttext: "Confirm Password",
          fgcolor: widget.fgcolor,
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
          height: 18.h,
        ),
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
            decoration: BoxDecoration(
              color: isDark ? kBlack20 : kGrey50,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 18 - 3.0),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
}
