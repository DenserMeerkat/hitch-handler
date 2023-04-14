// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customfields/customerrormsg.dart';
import 'package:hitch_handler/screens/components/customfields/fieldlabel.dart';
import 'package:hitch_handler/string_extensions.dart';

class CustomMessageField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final String title;
  final int length;
  final String errorText;
  final TextEditingController controller;

  static bool hasError = false;
  static bool focusState = false;

  const CustomMessageField({
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
  late Color errorColor;
  late String errorText = widget.errorText;
  String validateField(String? value) {
    if (value!.isWhitespace()) {
      setState(() {
        CustomMessageField.hasError = true;
        errorText = "${widget.title} can't be empty";
      });
      return "Error!";
    } else {
      setState(() {
        CustomMessageField.hasError = false;
        errorText = "";
      });
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    errorColor = AdaptiveTheme.of(context).theme.colorScheme.error;
    var enabledBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
        borderSide: BorderSide.none);

    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
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
                bgcolor: isDark ? kBlack20 : kGrey30,
                tooltip: "min : 10\nmax : 50",
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
                  color: isDark ? kGrey50 : kLBlack10,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: isDark ? 0.5 : 1,
                      color: errorText == '' ? fieldState() : fieldState()),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1.5),
                      color: errorText == '' ? fieldState() : fieldState(),
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
                  textInputAction: TextInputAction.newline,
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
                  style: AdaptiveTheme.of(context)
                      .theme
                      .textTheme
                      .bodyMedium!
                      .copyWith(
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
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: isDark ? kGrey90 : kLGrey50,
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
        Offstage(
          offstage: errorText != '',
          child: const SizedBox(
            height: 10,
          ),
        ),
        Offstage(
          offstage: errorText == '',
          child: CustomErrorMsg(
            padLeft: 5.0,
            padTop: 0,
            padBottom: 0,
            errorText: errorText,
            errorIcon: errorIcon,
          ),
        ),
      ],
    );
  }

  Color fieldState() {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (CustomMessageField.hasError) {
      return AdaptiveTheme.of(context).theme.colorScheme.error;
    } else if (CustomMessageField.focusState) {
      return isDark ? kStudentColor.withOpacity(0.9) : kLTextColor;
    } else if (widget.controller.text != "" && !CustomMessageField.hasError) {
      return kPrimaryColor.withOpacity(0.8);
    } else {
      return isDark ? kBlack20 : kGrey150;
    }
  }
}
