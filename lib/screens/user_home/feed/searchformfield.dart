import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';

class SearchFormField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final TextEditingController controller;
  final Function(String?) onSearch;

  const SearchFormField({
    super.key,
    required this.fgcolor,
    this.hintText = "Search",
    required this.controller,
    required this.onSearch,
  });
  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  _SearchFormFieldState();

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;

  @override
  Widget build(BuildContext context) {
    var enabledBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide.none);
    Size size = MediaQuery.of(context).size;
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          //width: double.infinity,
          child: Focus(
            onFocusChange: (focus) {
              widget.onSearch(widget.controller.text);
            },
            child: TextFormField(
              onEditingComplete: () {
                widget.onSearch(widget.controller.text);
              },
              onSaved: (value) {
                widget.onSearch(value);
              },
              onFieldSubmitted: (value) {
                widget.onSearch(value);
              },
              //autofocus: true,
              controller: widget.controller,
              cursorColor: kPrimaryColor,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: isDark ? kTextColor : kLTextColor,
                  size: 20,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                hintText: widget.hintText,
                hintStyle: AdaptiveTheme.of(context)
                    .theme
                    .textTheme
                    .bodySmall!
                    .copyWith(
                      fontSize: 14,
                      color: isDark
                          ? kTextColor.withOpacity(0.8)
                          : kLTextColor.withOpacity(0.8),
                    ),
                border: enabledBorder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
