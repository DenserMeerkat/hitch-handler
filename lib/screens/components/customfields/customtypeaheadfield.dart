import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
import '../../../resources/post_methods.dart';
import 'customerrormsg.dart';
import 'fieldlabel.dart';

class CustomTypeAheadField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final String title;
  final int length;
  final bool showErrors;
  final String errorText;
  final TextEditingController controller;

  static bool hasError = false;
  static bool focusState = false;

  const CustomTypeAheadField({
    super.key,
    required this.fgcolor,
    this.hintText = "HintText",
    this.title = "Title",
    this.length = 30,
    required this.controller,
    this.errorText = '',
    required this.showErrors,
  });
  @override
  State<CustomTypeAheadField> createState() => _CustomTypeAheadFieldState();
}

class _CustomTypeAheadFieldState extends State<CustomTypeAheadField> {
  _CustomTypeAheadFieldState();

  IconData errorIcon = Icons.error;
  late Color errorColor;
  late String errorText = widget.errorText;
  String validateField(String? value) {
    List list;
    if (widget.title == "Location") {
      list = LocationList.locationsList;
    } else {
      list = DomainList.domainsList;
    }
    if (value!.isWhitespace()) {
      setState(() {
        CustomTypeAheadField.hasError = true;
        errorText = "${widget.title} can't be empty";
      });
      return "Error!";
    } else if (!list.contains(value)) {
      setState(() {
        CustomTypeAheadField.hasError = true;
        errorText = "Choose a valid ${widget.title}";
      });
      return "Error!";
    } else {
      setState(() {
        CustomTypeAheadField.hasError = false;
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
                tooltip: "tooltip",
              ),
            ],
          ),
        ),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: isDark ? kGrey50 : kLBlack10,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2.5),
                color: errorText == '' ? fieldState() : fieldState(),
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
            child: TypeAheadFormField(
              validator: (value) {
                if (widget.showErrors) {
                  validateField(value);
                  String val = validateField(value);
                  if (val == "") {
                    return null;
                  } else {
                    return val;
                  }
                }
                return null;
              },
              minCharsForSuggestions: 1,
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              direction: AxisDirection.down,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                color: isDark ? kBlack20 : kLBlack10,
                shadowColor: kGrey30,
              ),
              textFieldConfiguration: TextFieldConfiguration(
                style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                onChanged: (value) {
                  if (widget.showErrors) {
                    validateField(value);
                  }
                },
                onSubmitted: (value) {
                  if (widget.showErrors) {
                    validateField(value);
                  }
                },
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 180),
                controller: widget.controller,
                autofocus: false,
                cursorColor: widget.fgcolor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: isDark ? kGrey90 : kLGrey50,
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
                if (widget.title == "Location") {
                  return LocationList.getSuggestions(pattern);
                } else if (widget.title == "Domain") {
                  return DomainList.getSuggestions(pattern);
                }
                return LocationList.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: Colors.transparent,
                  splashColor: isDark ? Colors.white24 : Colors.black45,
                  iconColor: kPrimaryColor,
                  title: Row(
                    children: [
                      Icon(widget.title == "Location"
                          ? Icons.location_on_outlined
                          : Icons.domain_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        suggestion,
                        style: TextStyle(
                            color: isDark
                                ? kTextColor.withOpacity(0.7)
                                : kLTextColor.withOpacity(0.7),
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                widget.controller.text = suggestion;
                if (widget.showErrors) {
                  validateField(suggestion);
                }
              },
            ),
          ),
        ),
        CustomErrorMsg(
          padLeft: 5.0,
          padTop: 10.0,
          errorText: errorText,
          errorIcon: errorIcon,
        ),
      ],
    );
  }

  Color fieldState() {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (CustomTypeAheadField.hasError && widget.title != "Location") {
      return AdaptiveTheme.of(context).theme.colorScheme.error;
    } else if (CustomTypeAheadField.focusState) {
      return isDark ? kLPrimaryColor.withOpacity(0.9) : kStudentColor;
    } else if (widget.controller.text != "" && !CustomTypeAheadField.hasError) {
      return kPrimaryColor.withOpacity(0.8);
    } else {
      return isDark ? kBlack20 : kGrey150;
    }
  }
}
