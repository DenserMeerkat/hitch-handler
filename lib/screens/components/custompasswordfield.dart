import 'package:flutter/material.dart';
import '../../string_extensions.dart';
import '../../constants.dart';
import 'customerrormsg.dart';

class CustomPasswordField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  final bool extraError;
  final bool showError;
  TextEditingController controller;
  Function(String) onSubmit;
  Function(String) onChange;
  CustomPasswordField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Password",
    required this.controller,
    required this.onSubmit,
    required this.onChange,
    this.extraError = false,
    this.showError = true,
  });
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState(
      fgcolor, hinttext, controller, extraError, showError, onChange, onSubmit);
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  final Color fgcolor;
  final String hinttext;
  final bool extraError;
  final bool showError;
  TextEditingController controller;
  Function(String) onChange;
  Function(String) onSubmit;
  _CustomPasswordFieldState(this.fgcolor, this.hinttext, this.controller,
      this.extraError, this.showError, this.onSubmit, this.onChange);
  bool _obscureText = true;
  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  String? validateField(String? value) {
    if (value!.isWhitespace()) {
      setState(() {
        errorText = "Password can't be empty!";
      });
    } else {
      if (extraError == true) {
        if (!value.isValidPassword()) {
          setState(() {
            errorText = "Not a Valid Password!";
          });
        } else {
          setState(() {
            errorText = "";
          });
          return '';
        }
      } else {
        if (value.length < 8) {
          setState(() {
            errorText = "Password is atleast 8 characters";
          });
        } else {
          setState(() {
            errorText = "";
          });
          return '';
        }
      }
    }
    return errorText;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Positioned(
              height: 48,
              top: 0,
              right: 0,
              child: Container(
                height: 48,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(50, 50, 50, 1),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 2),
                      color: Color.fromRGBO(20, 20, 20, 1),
                    )
                  ],
                ),
                child: const SizedBox(
                  height: 48,
                ),
              ),
            ),
            TextFormField(
              controller: controller,
              onFieldSubmitted: (value) {
                onSubmit(value);
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                onChange(value);
                validateField(value);
              },
              validator: (value) {
                String? val = validateField(value);
                if (val == "") {
                  controller.text = value!;
                  return null;
                } else {
                  return val;
                }
              },
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 1,
              ),
              cursorColor: fgcolor,
              cursorHeight: 16.0,
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    splashRadius: 50.0,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: fgcolor,
                      size: 18,
                    ),
                  ),
                ),
                errorStyle: const TextStyle(
                  height: 0,
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                isDense: true,
                helperText: '_',
                helperStyle: const TextStyle(
                  height: 0,
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                suffixIconColor: fgcolor,
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(20, 20, 20, 1),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Color.fromRGBO(10, 10, 10, 1),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.password,
                    color: fgcolor,
                    size: 20,
                  ),
                ),
                hintText: hinttext,
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Color.fromRGBO(90, 90, 90, 1),
                  letterSpacing: 0.5,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                  gapPadding: 0,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                  gapPadding: 0,
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                  gapPadding: 0,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                  gapPadding: 0,
                ),
              ),
            ),
          ],
        ),
        CustomErrorMsg(
          errorText: showErrorBool(),
          errorColor: errorColor,
          errorIcon: errorIcon,
          padBottom: 0.0,
        ),
      ],
    );
  }

  String showErrorBool() {
    if (showError == true) {
      return errorText;
    } else {
      return '';
    }
  }
}
