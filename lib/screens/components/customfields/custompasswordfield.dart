import 'package:flutter/material.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
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
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  _CustomPasswordFieldState();
  bool _obscureText = true;
  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  String? validateField(String? value) {
    if (value!.isWhitespace()) {
      setState(() {
        errorText = "Password can't be empty";
      });
    } else {
      if (widget.extraError == true) {
        if (!value.isValidPassword()) {
          setState(() {
            errorText = "Not a Valid Password";
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
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      borderSide: BorderSide.none,
      gapPadding: 0,
    );
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
                  color: kGrey50,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    errorIndicator(),
                    const BoxShadow(
                      offset: Offset(1, 2),
                      color: kBlack20,
                    )
                  ],
                ),
                child: const SizedBox(
                  height: 48,
                ),
              ),
            ),
            TextFormField(
              controller: widget.controller,
              onFieldSubmitted: (value) {
                widget.onSubmit(value);
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                widget.onChange(value);
                validateField(value);
              },
              validator: (value) {
                String? val = validateField(value);
                if (val == "") {
                  widget.controller.text = value!;
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
              cursorColor: widget.fgcolor,
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
                      color: widget.fgcolor,
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
                suffixIconColor: widget.fgcolor,
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: kBlack20,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: kBlack10,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.password,
                    color: widget.fgcolor,
                    size: 20,
                  ),
                ),
                hintText: widget.hinttext,
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: kGrey90,
                  letterSpacing: 0.5,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder,
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
    if (widget.showError == true) {
      return errorText;
    } else {
      return '';
    }
  }

  BoxShadow errorIndicator() {
    if (errorText != '') {
      return const BoxShadow(
        offset: Offset(1, 3.5),
        color: kErrorColor,
      );
    } else {
      return const BoxShadow(
        offset: Offset(0, 0),
        color: Colors.transparent,
      );
    }
  }
}
