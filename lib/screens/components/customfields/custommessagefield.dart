import 'package:flutter/material.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
import 'customerrormsg.dart';
import 'fieldlabel.dart';

class CustomMessageField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final String title;
  final int length;
  String errorText;
  TextEditingController controller;

  static bool hasError = false;
  static bool focusState = false;

  CustomMessageField({
    super.key,
    required this.fgcolor,
    this.hintText = "HintText",
    this.title = "Title",
    this.length = 30,
    required this.controller,
    this.errorText = '',
  });
  @override
  State<CustomMessageField> createState() => _CustomMessageFieldState();
}

class _CustomMessageFieldState extends State<CustomMessageField> {
  _CustomMessageFieldState();

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  Color fieldBorderColor = kBlack20;

  String validateField(String? value) {
    if (value!.isWhitespace()) {
      setState(() {
        CustomMessageField.hasError = true;
        widget.errorText = "${widget.title} can\'t be empty";
        fieldBorderColor = fieldState();
      });
      return "Error!";
    } else {
      setState(() {
        CustomMessageField.hasError = false;
        widget.errorText = "";
        fieldBorderColor = fieldState();
      });
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var enabledBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
        borderSide: BorderSide.none);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FieldLabel(
                fgcolor: widget.fgcolor,
                title: widget.title,
                bgcolor: kBlack20,
                tooltip: "min : 50\nmax : 250",
              ),
            ],
          ),
        ),
        SizedBox(
          height: 146,
          width: size.width * 0.8,
          child: Stack(
            children: [
              Container(
                height: 132,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: kGrey50,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2.5),
                      color:
                          widget.errorText == '' ? fieldState() : fieldState(),
                    ),
                  ],
                ),
              ),
              Focus(
                onFocusChange: (focus) {
                  setState(() {
                    CustomMessageField.focusState = focus;
                    fieldState();
                  });
                },
                child: TextFormField(
                  minLines: 7,
                  maxLines: 7,
                  controller: widget.controller,
                  onChanged: (value) {
                    validateField(value);
                  },
                  validator: (value) {
                    validateField(value);
                    String val = validateField(value);
                    if (val == "") {
                      setState(() {
                        widget.controller.text = value!;
                      });
                      return null;
                    } else {
                      return val;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    widget.controller.text = value;
                    validateField(value);
                    FocusScope.of(context).nextFocus();
                  },
                  maxLength: widget.length,
                  keyboardType: TextInputType.multiline,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 80),
                  cursorColor: widget.fgcolor,
                  style: const TextStyle(
                    fontSize: 17.0,
                    letterSpacing: 1,
                  ),
                  decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        height: 0,
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                        color: kGrey90,
                        letterSpacing: 1,
                      ),
                      helperText: "_",
                      helperStyle: const TextStyle(
                        height: 0,
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      errorStyle: const TextStyle(
                        height: 0,
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      //label: FieldLabel(fgcolor: fgcolor),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      enabledBorder: enabledBorder,
                      focusedBorder: enabledBorder,
                      errorBorder: enabledBorder,
                      focusedErrorBorder: enabledBorder,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10)),
                ),
              ),
            ],
          ),
        ),
        CustomErrorMsg(
          padLeft: 5.0,
          padTop: 0,
          errorText: widget.errorText,
          errorColor: errorColor,
          errorIcon: errorIcon,
        ),
      ],
    );
  }

  Color fieldState() {
    if (CustomMessageField.hasError) {
      return kErrorColor;
    } else if (CustomMessageField.focusState) {
      return kStudentColor.withOpacity(0.9);
    } else if (widget.controller.text != "" && !CustomMessageField.hasError) {
      return kPrimaryColor.withOpacity(0.8);
    } else {
      return kBlack20;
    }
  }
}
