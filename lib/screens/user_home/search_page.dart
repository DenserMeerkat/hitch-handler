import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/user_home/feed/searchformfield.dart';

import '../../resources/post_methods.dart';
import '../components/appbar.dart';
import 'feed/searchfield.dart';

class SearchPage extends StatefulWidget {
  static String routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<IconData> searchOptions = [
    Icons.title,
    Icons.domain_outlined,
    Icons.location_on_outlined,
  ];
  int currentIndex = 0;
  IconData currentIcon = Icons.title;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void changeSearch(int index) {
    setState(() {
      currentIndex = index;
      currentIcon = searchOptions[index];
    });
  }

  var currentStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy("datePublished", descending: true)
      .snapshots();
  final List streams = [
    FirebaseFirestore.instance
        .collection('posts')
        .where(
          'title',
        )
        .snapshots(),
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("upVoteCount", descending: true)
        .snapshots(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
      appBar: const MainAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: IconButton(
                      splashColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      focusColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      highlightColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      hoverColor: isDark
                          ? kTextColor.withOpacity(0.1)
                          : kLTextColor.withOpacity(0.1),
                      style:
                          AdaptiveTheme.of(context).theme.iconButtonTheme.style,
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: isDark ? kTextColor : kLTextColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      tooltip: "Back",
                    ),
                  ),
                );
              },
            ),
            backgroundColor: isDark ? kBackgroundColor : kLBlack20,
            surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
            elevation: 0,
            expandedHeight: 60,
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: isDark ? kGrey40 : kLGrey40),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 50,
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
                                border: Border.all(
                                  color: isDark ? kGrey40 : kLGrey40,
                                ),
                                color: isDark
                                    ? kGrey40.withOpacity(0.6)
                                    : kLBlack10,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child:
                                  // Autocomplete<User>(
                                  //   displayStringForOption: _displayStringForOption,
                                  //   optionsBuilder:
                                  //       (TextEditingValue textEditingValue) {
                                  //     if (textEditingValue.text == '') {
                                  //       return const Iterable<User>.empty();
                                  //     }
                                  //     return _userOptions.where((User option) {
                                  //       return option.toString().contains(
                                  //           textEditingValue.text.toLowerCase());
                                  //     });
                                  //   },
                                  //   onSelected: (User selection) {
                                  //     debugPrint(
                                  //         'You just selected ${_displayStringForOption(selection)}');
                                  //   },
                                  //     // ),

                                  currentIndex == 2
                                      ? SearchFormField(
                                          hintText: "Search",
                                          controller: searchController,
                                          fgcolor: isDark
                                              ? kPrimaryColor
                                              : kLPrimaryColor,
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: SearchField(
                                            hintText: "Search",
                                            hintColor: isDark
                                                ? kTextColor
                                                : kLTextColor,
                                            controller: searchController,
                                            fgcolor: isDark
                                                ? kPrimaryColor
                                                : kLPrimaryColor,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Theme(
                        data: AdaptiveTheme.of(context).theme.copyWith(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                        child: PopupMenuButton(
                          tooltip: "Search Options",
                          constraints:
                              const BoxConstraints(minWidth: 20, maxWidth: 180),
                          color: isDark ? kGrey40 : kLBlack10,
                          surfaceTintColor: isDark ? kGrey40 : kLBlack10,
                          offset: Offset(4.w, 45.h),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<int>(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 16,
                                ),
                                onTap: () {},
                                value: 0,
                                child: Text(
                                  "Search by",
                                  style: AdaptiveTheme.of(context)
                                      .theme
                                      .textTheme
                                      .displayMedium,
                                ),
                              ),
                              PopupMenuItem<int>(
                                height: 40,
                                onTap: () {
                                  changeSearch(0);
                                },
                                value: 0,
                                child: PopupItem(
                                  icon: Icons.title,
                                  isSelected: currentIndex == 0,
                                  title: 'Title',
                                ),
                              ),
                              PopupMenuItem<int>(
                                height: 40,
                                onTap: () {
                                  changeSearch(1);
                                },
                                value: 1,
                                child: PopupItem(
                                  icon: Icons.domain_outlined,
                                  isSelected: currentIndex == 1,
                                  title: 'Domain',
                                ),
                              ),
                              PopupMenuItem<int>(
                                height: 40,
                                onTap: () {
                                  changeSearch(2);
                                },
                                value: 2,
                                child: PopupItem(
                                  icon: Icons.location_on_outlined,
                                  isSelected: currentIndex == 2,
                                  title: 'Location',
                                ),
                              ),
                            ];
                          },
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            height: double.infinity,
                            //color: Colors.green,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark ? kGrey40 : kLGrey40,
                              ),
                              color:
                                  isDark ? kGrey40.withOpacity(0.6) : kLBlack10,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  currentIcon,
                                  size: 18,
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
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
          SliverToBoxAdapter(
            child: Container(),
          )
        ],
      ),
    );
  }
}
