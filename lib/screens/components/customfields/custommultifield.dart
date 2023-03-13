import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';
import '../../../string_extensions.dart';
import 'customerrormsg.dart';

class CustomMultiField extends StatefulWidget {
  final Color fgcolor;
  final int index;
  final int current;
  final List<String> hints;
  final List<IconData> icons;
  final List<TextInputType> keyboards;
  final TextEditingController controller;
  const CustomMultiField({
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
  late int current = widget.current;
  late String hinttext = widget.hints[current];
  late IconData icondata = widget.icons[current];
  late TextInputType keyboardtype = widget.keyboards[current];

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
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0.r),
        bottom: Radius.circular(10.0.r),
      ),
      borderSide: BorderSide.none,
      gapPadding: 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(fit: StackFit.passthrough, children: [
          Container(
            height: 48,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDark ? kGrey50 : kLBlack10,
              borderRadius: BorderRadius.circular(10.0.r),
              boxShadow: [
                errorIndicator(),
                BoxShadow(
                  offset: const Offset(1, 2),
                  color: isDark ? kBlack20 : kLGrey70,
                ),
              ],
            ),
            child: const SizedBox(
              height: 48,
            ),
          ),
          TextFormField(
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              validateField(value, current);
            },
            controller: widget.controller,
            validator: (value) {
              String val = validateField(value, current);
              if (val == "") {
                setState(() {
                  widget.controller.text = value!;
                });
                return null;
              } else {
                return val;
              }
            },
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 16.0.sp,
                      letterSpacing: 1.w,
                      color: isDark ? kTextColor : kLTextColor,
                    ),
            cursorColor: widget.fgcolor,
            cursorHeight: 20.0.sp,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => {FocusScope.of(context).nextFocus()},
            keyboardType: keyboardtype,
            decoration: InputDecoration(
              // fillColor: isDark ? kGrey50 : kLBlack10,
              // filled: true,
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
                    icondata = widget.icons[current];
                    hinttext = widget.hints[current];
                    keyboardtype = widget.keyboards[current];
                  });
                },
                child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    setState(() {
                      //__________________SET STATE___________
                      reset();
                      if (current < widget.index - 1) {
                        current += 1;
                      } else {
                        current = 0;
                      }
                      icondata = widget.icons[current];
                      hinttext = widget.hints[current];
                      keyboardtype = widget.keyboards[current];
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
                        blurRadius: 3,
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
              helperText: '',
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
                  color: isDark ? kBlack20 : kGrey50,
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
                fontSize: 15.0.sp,
                color: isDark ? kGrey90 : kGrey90.withOpacity(0.7),
                letterSpacing: 0.5.sp,
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
          errorText: errorText,
          errorIcon: errorIcon,
        ),
      ],
    );
  }

  BoxShadow errorIndicator() {
    if (errorText != '') {
      return BoxShadow(
        offset: const Offset(1, 3.5),
        color: AdaptiveTheme.of(context).theme.colorScheme.error,
      );
    } else {
      return const BoxShadow(
        offset: Offset(0, 0),
        color: Colors.transparent,
      );
    }
  }
}
