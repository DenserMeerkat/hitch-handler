import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hitch_handler/constants.dart';

import '../../resources/post_methods.dart';

class SearchPage extends StatefulWidget {
  static String routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var enabledBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      ),
      borderSide: BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: SafeArea(
        child: SizedBox(
          height: 50,
          width: 500,
          child: Container(
            color: Colors.red,
          ),
          // child: TypeAheadField(
          //   minCharsForSuggestions: 1,
          //   hideOnEmpty: true,
          //   hideSuggestionsOnKeyboardHide: true,
          //   direction: AxisDirection.down,
          //   suggestionsBoxDecoration: SuggestionsBoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: kBlack20,
          //     shadowColor: kGrey30,
          //   ),
          //   textFieldConfiguration: TextFieldConfiguration(
          //     scrollPadding: EdgeInsets.only(
          //         bottom: MediaQuery.of(context).viewInsets.bottom + 180),
          //     onSubmitted: (value) {},
          //     autofocus: false,
          //     cursorColor: kPrimaryColor,
          //     decoration: InputDecoration(
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //       hintText: "Search",
          //       hintStyle: const TextStyle(
          //         fontSize: 15.0,
          //         color: kGrey90,
          //         letterSpacing: 1,
          //       ),
          //       border: enabledBorder,
          //     ),
          //   ),
          //   noItemsFoundBuilder: (context) => ListTile(
          //     iconColor: kPrimaryColor,
          //     title: Row(
          //       children: const [
          //         Icon(Icons.location_on_outlined),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text("Others"),
          //       ],
          //     ),
          //   ),
          //   suggestionsCallback: (pattern) async {
          //     return LocationList.getSuggestionLocations(pattern);
          //   },
          //   itemBuilder: (context, suggestion) {
          //     return ListTile(
          //       dense: true,
          //       iconColor: kPrimaryColor,
          //       title: Row(
          //         children: [
          //           const Icon(Icons.location_on_outlined),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Text(
          //             suggestion,
          //             style: TextStyle(
          //                 color: kTextColor.withOpacity(0.7), letterSpacing: 1),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   onSuggestionSelected: (suggestion) {},
          // ),
        ),
      ),
    );
  }
}
