import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../string_extensions.dart';
import '../../constants.dart';
import 'customerrormsg.dart';

class CustomDatePickField extends StatefulWidget {
  const CustomDatePickField({
    super.key,
    required this.fgcolor,
    this.hinttext = "Date of Birth",
  });
  final Color fgcolor;
  final String hinttext;
  @override
  State<CustomDatePickField> createState() =>
      _CustomDatePickFieldState(fgcolor, hinttext);
}

class _CustomDatePickFieldState extends State<CustomDatePickField> {
  final Color fgcolor;
  final String hinttext;
  _CustomDatePickFieldState(this.fgcolor, this.hinttext);
  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  String errorText = "";

  void validateField(String? value) {
    String errormsg = "";
    if (value!.isWhitespace()) {
      errormsg = "$hinttext can\'t be empty!";
    } else if (value.isValidName()) {
      errormsg = "";
    }
    setState(() {
      errorText = errormsg;
    });
  }

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormField<String>(builder: (FormFieldState<String> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
              validator: (value) {
                validateField(value);
              },
              showCursor: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickeddate = await showCustomDatePicker(context);
                if (pickeddate != null) {
                  setState(() {
                    _textEditingController.text =
                        DateFormat('dd-MM-yyyy').format(pickeddate);
                  });
                }
              },
              controller: _textEditingController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => {FocusScope.of(context).nextFocus()},
              keyboardType: TextInputType.name,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              style: const TextStyle(
                fontSize: 16.0,
                letterSpacing: 1,
              ),
              cursorColor: fgcolor,
              cursorHeight: 16.0,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    DateTime? pickeddate = await showCustomDatePicker(context);
                    if (pickeddate != null) {
                      setState(() {
                        _textEditingController.text =
                            DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },
                  child: IconButton(
                    splashRadius: 50.0,
                    onPressed: () async {
                      DateTime? pickeddate =
                          await showCustomDatePicker(context);
                      if (pickeddate != null) {
                        setState(() {
                          _textEditingController.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit_calendar_outlined,
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
                    Icons.date_range,
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
          ),
          CustomErrorMsg(
              errorText: errorText,
              errorColor: errorColor,
              errorIcon: errorIcon),
        ],
      );
    });
  }

  Future<DateTime?> showCustomDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
                onPrimary: kBackgroundColor, // selected text color
                onSurface: kTextColor, // default text color
                primary: fgcolor.withOpacity(0.9) // circle color
                ),
            dialogBackgroundColor: const Color.fromRGBO(40, 40, 40, 1),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: fgcolor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 12,
                ),
                foregroundColor: kBackgroundColor, // color of button's letters
                backgroundColor: fgcolor.withOpacity(0.8), // Background color
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: fgcolor,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
