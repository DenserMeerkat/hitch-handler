import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../string_extensions.dart';
import '../../../constants.dart';
import '../../../resources/post_methods.dart';

class SearchField extends StatefulWidget {
  final Color fgcolor;
  final String hintText;
  final TextEditingController controller;

  const SearchField({
    super.key,
    required this.fgcolor,
    this.hintText = "Search",
    required this.controller,
  });
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  _SearchFieldState();

  IconData errorIcon = Icons.error;
  Color errorColor = kErrorColor;

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

    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          //width: double.infinity,
          child: Focus(
            onFocusChange: (focus) {},
            child: TypeAheadFormField(
              minCharsForSuggestions: 1,
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              direction: AxisDirection.down,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                color: isDark ? kBlack20 : kLBlack20,
                shadowColor: kGrey30,
              ),
              textFieldConfiguration: TextFieldConfiguration(
                textInputAction: TextInputAction.search,
                style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                onChanged: (value) {},
                onSubmitted: (value) {},
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 180),
                controller: widget.controller,
                autofocus: false,
                cursorColor: widget.fgcolor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: isDark ? kTextColor.withOpacity(0.5) : kLTextColor,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  hintText: widget.hintText,
                  hintStyle: AdaptiveTheme.of(context)
                      .theme
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        fontWeight: FontWeight.normal,
                        color:
                            isDark ? kTextColor.withOpacity(0.5) : kLTextColor,
                      ),
                  border: enabledBorder,
                ),
              ),
              noItemsFoundBuilder: (context) => const ListTile(
                iconColor: kPrimaryColor,
                title: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Others"),
                  ],
                ),
              ),
              suggestionsCallback: (pattern) async {
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
                      Icon(Icons.domain_outlined),
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
