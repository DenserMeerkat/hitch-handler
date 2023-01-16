import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
import '../../user_home/add/addpostbrain.dart';
import 'customerrormsg.dart';
import 'fieldlabel.dart';

class CustomTypeAheadField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final String title;
  final int length;
  String errorText;
  TextEditingController controller;

  static bool hasError = false;
  static bool focusState = false;

  CustomTypeAheadField({
    super.key,
    required this.fgcolor,
    this.hintText = "HintText",
    this.title = "Title",
    this.length = 30,
    required this.controller,
    this.errorText = '',
  });
  @override
  State<CustomTypeAheadField> createState() => _CustomTypeAheadFieldState();
}

class _CustomTypeAheadFieldState extends State<CustomTypeAheadField> {
  _CustomTypeAheadFieldState();

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;
  Color fieldBorderColor = kBlack20;

  String validateField(String? value) {
    if (value!.isWhitespace()) {
      setState(() {
        CustomTypeAheadField.hasError = true;
        widget.errorText = "${widget.title} can't be empty";
        fieldBorderColor = fieldState();
      });
      return "Error!";
    } else {
      setState(() {
        CustomTypeAheadField.hasError = false;
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
                tooltip: "tooltip",
              ),
            ],
          ),
        ),
        Container(
          height: 50,
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
                color: widget.errorText == '' ? fieldState() : fieldState(),
              ),
            ],
          ),
          child: Focus(
            onFocusChange: (focus) {
              setState(() {
                CustomTypeAheadField.focusState = focus;
                fieldState();
              });
            },
            child: TypeAheadField(
              minCharsForSuggestions: 1,
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              direction: AxisDirection.down,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kBlack20,
                shadowColor: kGrey30,
              ),
              textFieldConfiguration: TextFieldConfiguration(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 180),
                onSubmitted: (value) {
                  widget.controller.text = value;
                },
                controller: widget.controller,
                autofocus: false,
                cursorColor: widget.fgcolor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    color: kGrey90,
                    letterSpacing: 1,
                  ),
                  border: enabledBorder,
                ),
              ),
              noItemsFoundBuilder: (context) => ListTile(
                iconColor: kPrimaryColor,
                title: Row(
                  children: const [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Others"),
                  ],
                ),
              ),
              suggestionsCallback: (pattern) async {
                return LocationList.getSuggestionLocations(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  dense: true,
                  iconColor: kPrimaryColor,
                  title: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        suggestion,
                        style: TextStyle(
                            color: kTextColor.withOpacity(0.7),
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                widget.controller.text = suggestion;
              },
            ),
          ),
        ),
        CustomErrorMsg(
          padLeft: 5.0,
          padTop: 10,
          errorText: widget.errorText,
          errorColor: errorColor,
          errorIcon: errorIcon,
        ),
      ],
    );
  }

  Color fieldState() {
    if (CustomTypeAheadField.hasError) {
      return kErrorColor;
    } else if (CustomTypeAheadField.focusState) {
      return kStudentColor.withOpacity(0.9);
    } else if (widget.controller.text != "" && !CustomTypeAheadField.hasError) {
      return kPrimaryColor.withOpacity(0.8);
    } else {
      return kBlack20;
    }
  }
}
