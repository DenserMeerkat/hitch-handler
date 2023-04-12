import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/popupitem.dart';
import 'package:hitch_handler/screens/common/post/postcard.dart';
import 'package:hitch_handler/screens/user_home/feed/searchformfield.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:hitch_handler/screens/components/appbar.dart';

class SearchPage extends StatefulWidget {
  static String routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<IconData> searchOptions = [
    MdiIcons.linkVariant,
    Icons.title,
    Icons.domain_outlined,
    Icons.location_on_outlined,
  ];
  final List<String> searchHints = [
    "Search by Post-Id",
    "Search by Title",
    "Search by Domain",
    "Search by Location",
  ];
  late int currentIndex;
  late IconData currentIcon;
  final TextEditingController searchController = TextEditingController();
  late dynamic postIdStream;
  late String previousSearch = "";
  @override
  void initState() {
    currentIndex = 0;
    currentIcon = searchOptions[0];
    postIdStream = FirebaseFirestore.instance
        .collection('posts')
        .where('postId', isEqualTo: searchController.text)
        .snapshots();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
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
                              child: SearchFormField(
                                hintText: searchHints[currentIndex],
                                controller: searchController,
                                fgcolor:
                                    isDark ? kPrimaryColor : kLPrimaryColor,
                                onSearch: (value) {
                                  if (value != null &&
                                      value != "" &&
                                      (previousSearch != ""
                                          ? value != previousSearch
                                          : true)) {
                                    setState(() {
                                      previousSearch = value;
                                      postIdStream = FirebaseFirestore.instance
                                          .collection('posts')
                                          .where('postId', isEqualTo: value)
                                          .snapshots();
                                    });
                                  }
                                },
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
                                  icon: searchOptions[0],
                                  isSelected: currentIndex == 0,
                                  title: 'Post-Id',
                                ),
                              ),
                              PopupMenuItem<int>(
                                enabled: false,
                                height: 40,
                                onTap: () {
                                  changeSearch(1);
                                },
                                value: 1,
                                child: PopupItem(
                                  icon: Icons.more_horiz,
                                  isSelected: currentIndex == 1,
                                  title: 'More soon',
                                ),
                              ),
                              // PopupMenuItem<int>(
                              //   enabled: false,
                              //   height: 40,
                              //   onTap: () {
                              //     changeSearch(1);
                              //   },
                              //   value: 1,
                              //   child: PopupItem(
                              //     icon: searchOptions[1],
                              //     isSelected: currentIndex == 1,
                              //     title: 'Title',
                              //   ),
                              // ),
                              // PopupMenuItem<int>(
                              //   enabled: false,
                              //   height: 40,
                              //   onTap: () {
                              //     changeSearch(2);
                              //   },
                              //   value: 2,
                              //   child: PopupItem(
                              //     icon: searchOptions[2],
                              //     isSelected: currentIndex == 2,
                              //     title: 'Domain',
                              //   ),
                              // ),
                              // PopupMenuItem<int>(
                              //   enabled: false,
                              //   height: 40,
                              //   onTap: () {
                              //     changeSearch(3);
                              //   },
                              //   value: 3,
                              //   child: PopupItem(
                              //     icon: searchOptions[3],
                              //     isSelected: currentIndex == 3,
                              //     title: 'Location',
                              //   ),
                              // ),
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
          SliverFillRemaining(
            child: searchResult(),
          ),
        ],
      ),
    );
  }

  Widget searchResult() {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (searchController.text.isNotEmpty && currentIndex == 0) {
      return StreamBuilder(
        stream: postIdStream,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: kBlack20,
                color: kPrimaryColor,
              ),
            );
          }
          if (snapshot2.data!.docs.isEmpty) {
            return Center(
              child: Container(
                constraints: BoxConstraints(minHeight: 200, maxHeight: 340.h),
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? kGrey30 : kLGrey40,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  color: isDark ? kGrey30.withOpacity(0.4) : kLGrey30,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        size: 100,
                        color: kPrimaryColor,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 5),
                            color: isDark ? kBlack10 : kGrey40,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                        width: double.infinity,
                      ),
                      AutoSizeText(
                        "Could not find Post",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? kGrey150 : kGrey50,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot2.data!.docs.length,
            itemBuilder: (context, index) {
              dynamic snap = snapshot2.data!.docs[index].data();
              return PostCard(
                key: ValueKey(snap['postId']),
                snap: snap,
              );
            },
          );
        },
      );
    }
    return Container();
  }
}
