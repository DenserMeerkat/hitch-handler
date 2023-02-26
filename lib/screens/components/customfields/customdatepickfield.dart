import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
import '../utils/datetimepicker.dart';
import 'customerrormsg.dart';

class CustomDatePickField extends StatefulWidget {
  final Color fgcolor;
  final String hinttext;
  final TextEditingController controller;
  const CustomDatePickField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Date of Birth",
    required this.controller,
  });
  @override
  State<CustomDatePickField> createState() => _CustomDatePickFieldState();
}

class _CustomDatePickFieldState extends State<CustomDatePickField> {
  _CustomDatePickFieldState();
  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  String? validateField(String? value) {
    String errormsg = "";
    if (value!.isWhitespace()) {
      errormsg = "${widget.hinttext} can\'t be empty";
    } else if (value.isValidName()) {
      errormsg = "";
    }
    setState(() {
      errorText = errormsg;
    });
    if (errormsg != "") {
      return "Error!";
    }
    return null;
  }

  String? birthDateValidator(DateTime? value) {
    String errormsg = "";
    if (value == null) {
      errormsg = "DOB is required";
    } else if ((DateTime(DateTime.now().year, value.month, value.day)
                .isAfter(DateTime.now())
            ? DateTime.now().year - value.year - 1
            : DateTime.now().year - value.year) <
        18) {
      errormsg = "Must be atleast 18 years";
    } else {
      errormsg = "";
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
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0.r),
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
                width: 300.w,
                decoration: BoxDecoration(
                  color: isDark ? kGrey50 : kLGrey40,
                  borderRadius: BorderRadius.circular(10.0.r),
                  boxShadow: [
                    errorIndicator(),
                    BoxShadow(
                      offset: const Offset(1, 2),
                      color: isDark ? kBlack20 : kGrey90,
                    )
                  ],
                ),
                child: const SizedBox(
                  height: 48,
                ),
              ),
            ),
            TextFormField(
              onSaved: validateField,
              validator: validateDate,
              showCursor: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickeddate = await showCustomDatePicker(
                  context,
                  isDark ? kPrimaryColor : kLPrimaryColor,
                  DateTime.now(),
                );
                if (pickeddate != null) {
                  setState(() {
                    widget.controller.text =
                        DateFormat('dd-MM-yyyy').format(pickeddate);
                    validateDate(DateFormat('dd-MM-yyyy').format(pickeddate));
                  });
                }
              },
              controller: widget.controller,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => {FocusScope.of(context).nextFocus()},
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80.h),
              style: TextStyle(
                fontSize: 16.0.sp,
                color: isDark ? kTextColor : kLTextColor,
                letterSpacing: 0.5.sp,
              ),
              cursorColor: widget.fgcolor,
              cursorHeight: 20.sp,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    DateTime? pickeddate = await showCustomDatePicker(
                      context,
                      kPrimaryColor,
                      DateTime.now(),
                    );
                    if (pickeddate != null) {
                      setState(() {
                        widget.controller.text =
                            DateFormat('dd-MM-yyyy').format(pickeddate);
                        validateDate(
                            DateFormat('dd-MM-yyyy').format(pickeddate));
                      });
                    }
                  },
                  child: IconButton(
                    splashRadius: 50.0,
                    onPressed: () async {
                      DateTime? pickeddate = await showCustomDatePicker(
                        context,
                        kPrimaryColor,
                        DateTime.now(),
                      );
                      if (pickeddate != null) {
                        setState(() {
                          widget.controller.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                          validateDate(
                              DateFormat('dd-MM-yyyy').format(pickeddate));
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit_calendar_outlined,
                      color: widget.fgcolor,
                      size: 18,
                      shadows: [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          color: isDark ? kBlack20 : kGrey30,
                        )
                      ],
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
                  decoration: BoxDecoration(
                    color: isDark ? kBlack20 : kGrey30,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        blurRadius: 1,
                        color: isDark ? kBlack10 : kGrey30,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.date_range,
                    color: widget.fgcolor,
                    size: 20,
                  ),
                ),
                hintText: widget.hinttext,
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: isDark ? kGrey90 : kGrey90,
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
          errorText: errorText,
          errorColor: errorColor,
          errorIcon: errorIcon,
        ),
      ],
    );
  }

  String? validateDate(value) {
    if (value != "") {
      String? val = birthDateValidator(DateFormat("dd-MM-yyyy").parse(value!));
      if (val == "") {
        return null;
      } else {
        return val;
      }
    } else {
      return birthDateValidator(null);
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
