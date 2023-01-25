import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hitch_handler/constants.dart';

import '../../resources/post_methods.dart';
import 'appbar.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const MainAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  splashRadius: 20.0,
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: kTextColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tooltip: "Back",
                );
              },
            ),
            backgroundColor: kBackgroundColor,
            elevation: 0,
            expandedHeight: 60,
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: kGrey40))),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Hero(
                          tag: "search",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              height: double.infinity,
                              //color: Colors.green,
                              decoration: BoxDecoration(
                                border: Border.all(color: kGrey40),
                                color: kGrey40.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: kTextColor,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Search"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(),
          )
        ],
      ),
    );
  }
}
