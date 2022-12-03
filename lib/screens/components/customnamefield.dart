import 'package:flutter/material.dart';
import '../../string_extensions.dart';

import '../../constants.dart';
import 'customerrormsg.dart';

class CustomNameField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  Function(String) onSubmit;
  CustomNameField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Full Name",
    required this.onSubmit,
  });
  @override
  State<CustomNameField> createState() =>
      _CustomNameFieldState(fgcolor, hinttext, onSubmit);
}

class _CustomNameFieldState extends State<CustomNameField> {
  final Color fgcolor;
  final String hinttext;
  Function(String) onSubmit;
  _CustomNameFieldState(this.fgcolor, this.hinttext, this.onSubmit);

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  String? validateField(String? value) {
    String errormsg = "";
    if (value!.isWhitespace()) {
      errormsg = "$hinttext can\'t be empty!";
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

  final TextEditingController controller = TextEditingController();
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
              onChanged: (value) {
                validateField(value);
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                onSubmit;
                FocusScope.of(context).nextFocus();
              },
              keyboardType: TextInputType.name,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 1,
              ),
              cursorColor: fgcolor,
              cursorHeight: 16.0,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    splashRadius: 30.0,
                    onPressed: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                    icon: Icon(
                      Icons.backspace_outlined,
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
                    Icons.text_fields,
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
            errorText: errorText, errorColor: errorColor, errorIcon: errorIcon),
      ],
    );
  }
}
