import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../string_extensions.dart';
import 'customerrormsg.dart';

class CustomTextField extends StatefulWidget {
  final Color fgcolor;
  final int index;
  final int current;
  TextEditingController controller;
  CustomTextField(
      {super.key,
      required this.fgcolor,
      this.index = 3,
      this.current = 0,
      required this.controller});
  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState(fgcolor, index, controller, current);
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller;
  Color fgcolor;
  int current;
  final int index;
  late String hinttext = hints[current];
  late IconData icondata = icons[current];
  late TextInputType keyboardtype = keyboards[current];
  final List<String> hints = [
    'E-mail',
    'Phone',
    'ID Number',
  ];
  final List<IconData> icons = [
    Icons.alternate_email,
    Icons.call,
    Icons.badge,
  ];
  final List<TextInputType> keyboards = [
    TextInputType.emailAddress,
    TextInputType.phone,
    TextInputType.number,
  ];

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
      controller.clear();
      errorText = "";
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  String errorTextGen(int index, int error) {
    String type = hints[index];
    String errormsg;
    if (error == 1) {
      errormsg = "$type can\'t be empty!";
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
  _CustomTextFieldState(
      this.fgcolor, this.index, this.controller, this.current);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              validateField(value, current);
            },
            controller: controller,
            validator: (value) {
              String val = validateField(value, current);
              if (val == "") {
                setState(() {
                  controller.text = value!;
                });
                return null;
              } else {
                return val;
              }
            },
            style: const TextStyle(
              fontSize: 16.0,
            ),
            cursorColor: fgcolor,
            cursorHeight: 20.0,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => {FocusScope.of(context).nextFocus()},
            keyboardType: keyboardtype,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    //__________________SET STATE___________
                    reset();
                    if (current < 2) {
                      current += 1;
                    } else {
                      current = 0;
                    }
                    icondata = icons[current];
                    hinttext = hints[current];
                    keyboardtype = keyboards[current];
                  });
                },
                child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    setState(() {
                      //__________________SET STATE___________
                      reset();
                      if (current < index - 1) {
                        current += 1;
                      } else {
                        current = 0;
                      }
                      icondata = icons[current];
                      hinttext = hints[current];
                      keyboardtype = keyboards[current];
                    });
                  },
                  icon: Icon(
                    icondata,
                    size: 20.0,
                    color: fgcolor,
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
              suffixIconColor: fgcolor,
              icon: Container(
                height: 49,
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
                  Icons.account_circle,
                  color: fgcolor,
                  size: 20,
                ),
              ),
              hintText: hinttext, //_________________HINT TEXT____________
              hintStyle: const TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(90, 90, 90, 1),
                letterSpacing: 1,
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
        ]),
        CustomErrorMsg(
            errorText: errorText, errorColor: errorColor, errorIcon: errorIcon),
      ],
    );
  }
}
