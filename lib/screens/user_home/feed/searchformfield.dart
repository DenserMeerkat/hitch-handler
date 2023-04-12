import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  FocusNode fieldFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    var enabledBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
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
            focusNode: fieldFocus,
            onFocusChange: (focus) {
              //widget.onSearch(widget.controller.text);
            },
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: isDark ? kTextColor : kLTextColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
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
                    style: AdaptiveTheme.of(context)
                        .theme
                        .textTheme
                        .bodySmall!
                        .copyWith(
                          fontSize: 14,
                          color: isDark
                              ? kTextColor.withOpacity(0.8)
                              : kLTextColor.withOpacity(0.8),
                        ),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 0, right: 8),
                      hintText: widget.hintText,
                      hintStyle: AdaptiveTheme.of(context)
                          .theme
                          .textTheme
                          .bodySmall!
                          .copyWith(
                            fontSize: 14,
                            color: isDark
                                ? kTextColor.withOpacity(0.6)
                                : kLTextColor.withOpacity(0.6),
                          ),
                      border: enabledBorder,
                    ),
                  ),
                ),
                Tooltip(
                  message: "Paste",
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        if (widget.controller.text.isNotEmpty) {
                          setState(() {
                            widget.controller.clear();
                          });
                        } else {
                          pasteId();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          widget.controller.text.isNotEmpty
                              ? Icons.close
                              : Icons.content_paste_rounded,
                          color: isDark ? kTextColor : kLTextColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void pasteId() async {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    if (cdata == null ||
        (cdata.text != null
            ? cdata.text!.isWhitespace()
            : cdata.text == null)) {
      Fluttertoast.showToast(
          msg: "Clipboard Empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: isDark ? kGrey40 : kLBlack15,
          textColor: isDark ? kTextColor : kLTextColor,
          fontSize: 14.0);
    } else {
      if (!mounted) {
        return;
      }
      setState(() {
        widget.controller.text = cdata.text!;
      });
      widget.onSearch(widget.controller.text);
    }
  }
}
