import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Password",
  });
  final Color fgcolor;
  final String hinttext;
  @override
  State<CustomPasswordField> createState() =>
      _CustomPasswordFieldState(fgcolor, hinttext);
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  final Color fgcolor;
  final String hinttext;
  _CustomPasswordFieldState(this.fgcolor, this.hinttext);
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextFormField(
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
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
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
        ),
      ),
    );
  }
}
