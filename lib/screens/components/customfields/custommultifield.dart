import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../string_extensions.dart';
import 'customerrormsg.dart';

class CustomMultiField extends StatefulWidget {
  final Color fgcolor;
  final int index;
  int current;
  final List<String> hints;
  final List<IconData> icons;
  final List<TextInputType> keyboards;
  TextEditingController controller;
  CustomMultiField({
    super.key,
    required this.fgcolor,
    this.index = 1,
    this.current = 0,
    required this.controller,
    required this.hints,
    required this.icons,
    required this.keyboards,
  });
  @override
  State<CustomMultiField> createState() => _CustomMultiFieldState();
}

class _CustomMultiFieldState extends State<CustomMultiField> {
  _CustomMultiFieldState();
  late String hinttext = widget.hints[widget.current];
  late IconData icondata = widget.icons[widget.current];
  late TextInputType keyboardtype = widget.keyboards[widget.current];

  String validateField(String? value, int current) {
    String val = "";
    if (current == 0) {
      if (value!.isWhitespace()) {
        val = errorTextGen(current, 1);
      } else if (value.isValidEmail()) {
        val = errorTextGen(current, 0);
        return "";
      } else {
        val = errorTextGen(current, 2);
      }
    } else if (current == 1) {
      if (value!.isWhitespace()) {
        val = errorTextGen(current, 1);
      } else if (value.isValidMobile()) {
        val = errorTextGen(current, 0);
        return "";
      } else {
        val = errorTextGen(current, 2);
      }
    } else if (current == 2) {
      if (value!.isWhitespace()) {
        val = errorTextGen(current, 1);
      } else if (value.isValidRoll()) {
        val = errorTextGen(current, 0);
        return "";
      } else {
        val = errorTextGen(current, 2);
      }
    }
    return val;
  }

  void reset() {
    setState(() {
      widget.controller.clear();
      errorText = "";
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  String errorTextGen(int index, int error) {
    String type = widget.hints[index];
    String errormsg;
    if (error == 1) {
      errormsg = "$type can\'t be empty";
    } else if (error == 2) {
      errormsg = "Not a valid $type";
    } else {
      errormsg = "";
      setState(() {
        errorText = errormsg;
      });
      return errorText;
    }
    setState(() {
      errorText = errormsg;
    });
    return errorText;
  }

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
        Stack(children: [
          Positioned(
            height: 48,
            top: 0,
            right: 0,
            child: Container(
              height: 48,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: isDark ? kGrey50 : kLGrey40,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  errorIndicator(),
                  BoxShadow(
                    offset: const Offset(1, 2),
                    color: isDark ? kBlack20 : kGrey90,
                  ),
                ],
              ),
              child: const SizedBox(
                height: 48,
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              validateField(value, widget.current);
            },
            controller: widget.controller,
            validator: (value) {
              String val = validateField(value, widget.current);
              if (val == "") {
                setState(() {
                  widget.controller.text = value!;
                });
                return null;
              } else {
                return val;
              }
            },
            style: const TextStyle(
              fontSize: 16.0,
            ),
            cursorColor: widget.fgcolor,
            cursorHeight: 20.0,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => {FocusScope.of(context).nextFocus()},
            keyboardType: keyboardtype,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    //__________________SET STATE___________
                    reset();
                    if (widget.current < 2) {
                      widget.current += 1;
                    } else {
                      widget.current = 0;
                    }
                    icondata = widget.icons[widget.current];
                    hinttext = widget.hints[widget.current];
                    keyboardtype = widget.keyboards[widget.current];
                  });
                },
                child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    setState(() {
                      //__________________SET STATE___________
                      reset();
                      if (widget.current < widget.index - 1) {
                        widget.current += 1;
                      } else {
                        widget.current = 0;
                      }
                      icondata = widget.icons[widget.current];
                      hinttext = widget.hints[widget.current];
                      keyboardtype = widget.keyboards[widget.current];
                    });
                  },
                  icon: Icon(
                    icondata,
                    size: 20.0,
                    color: widget.fgcolor,
                    shadows: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: isDark ? kBlack20 : kGrey30,
                      )
                    ],
                  ), //_________________ICON DATA____________
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
                height: 49,
                width: 50,
                decoration: BoxDecoration(
                  color: isDark ? kBlack20 : kGrey30,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 1,
                      color: kBlack10,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.account_circle,
                  color: widget.fgcolor,
                  size: 20,
                ),
              ),
              hintText: hinttext, //_________________HINT TEXT____________
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: isDark ? kGrey90 : kGrey90,
                letterSpacing: 1,
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
        ]),
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
