import 'package:flutter/material.dart';
import '../../../string_extensions.dart';

import '../../../constants.dart';
import 'customerrormsg.dart';

class CustomNameField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  final TextEditingController controller;
  const CustomNameField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Full Name",
    required this.controller,
  });
  @override
  State<CustomNameField> createState() => _CustomNameFieldState();
}

class _CustomNameFieldState extends State<CustomNameField> {
  _CustomNameFieldState();

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  String? validateField(String? value) {
    String errormsg = "";
    if (value!.isWhitespace()) {
      errormsg = "${widget.hinttext} can\'t be empty!";
    } else if (value.isValidName()) {
      errormsg = "";
    } else {
      errormsg = "Valid Characters :  [a-z]  [A-Z]  [ , . - ' ]";
    }
    setState(() {
      errorText = errormsg;
    });
    if (errormsg != "") {
      return "Error!";
    }
    return null;
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
                  borderRadius: BorderRadius.circular(15.0),
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
              onChanged: (value) {
                widget.controller.text = value;
                validateField(value);
              },
              validator: (value) {
                widget.controller.text = value!;
                return validateField(value);
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                widget.controller.text = value;
                FocusScope.of(context).nextFocus();
              },
              keyboardType: TextInputType.name,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 1,
              ),
              cursorColor: widget.fgcolor,
              cursorHeight: 16.0,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.clear();
                    });
                  },
                  child: IconButton(
                    splashRadius: 30.0,
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                      });
                    },
                    icon: Icon(
                      Icons.backspace_outlined,
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
                      left: Radius.circular(15.0),
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
                    Icons.text_fields,
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
            errorText: errorText, errorColor: errorColor, errorIcon: errorIcon),
      ],
    );
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
