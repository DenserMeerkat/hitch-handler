import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/user_home/search_page.dart';
import '../../constants.dart';
import '../components/utils/customdialog.dart';
import 'feed/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<IconData> sortOptions = [
    Icons.schedule,
    Icons.thumb_up_alt_outlined
  ];
  int currentIndex = 0;
  IconData currentIcon = Icons.schedule;
  var currentStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy("datePublished", descending: true)
      .snapshots();
  final TextEditingController searchController = TextEditingController();
  final List streams = [
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("datePublished", descending: true)
        .snapshots(),
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("upVoteCount", descending: true)
        .snapshots(),
  ];
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void changeSort(int index) {
    setState(() {
      currentIndex = index;
      currentIcon = sortOptions[index];
      currentStream = streams[index];
      debugPrint('$currentIndex');
      debugPrint('$currentStream');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size

    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return StreamBuilder(
      stream: currentStream,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kBlack20,
              color: kPrimaryColor,
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              snap: true,
              //pinned: true,
              floating: true,
              backgroundColor: isDark ? kBackgroundColor : kLBlack20,
              surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
              elevation: 0,
              expandedHeight: 60,
              actions: <Widget>[Container()],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: isDark ? kGrey40 : kLGrey40),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SearchPage(),
                          transitionDuration: const Duration(milliseconds: 300),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Tooltip(
                      message: "Sort",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Hero(
                            tag: "search",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark ? kGrey40 : kLGrey40,
                                  ),
                                  color: isDark ? kGrey30 : kLBlack10,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: isDark ? kTextColor : kLTextColor,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Search",
                                      style: AdaptiveTheme.of(context)
                                          .theme
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: isDark
                                                ? kTextColor
                                                : kLTextColor,
                                          ),
                                    ),
                                    const SizedBox(width: 18),
                                  ],
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
                              tooltip: "Sort Options",
                              constraints: const BoxConstraints(
                                  minWidth: 20, maxWidth: 180),
                              color: isDark ? kGrey40 : kLBlack10,
                              surfaceTintColor: isDark ? kGrey40 : kLBlack10,
                              offset: Offset(4.w, 45.h),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem<int>(
                                    height: 30,
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 0, 4),
                                    onTap: () {},
                                    value: 0,
                                    child: Text(
                                      "Sort Posts by",
                                      style: AdaptiveTheme.of(context)
                                          .theme
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    height: 40,
                                    onTap: () {
                                      changeSort(0);
                                    },
                                    value: 0,
                                    child: PopupItem(
                                      icon: sortOptions[0],
                                      isSelected: currentIndex == 0,
                                      title: 'Date Posted',
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    height: 40,
                                    onTap: () {
                                      changeSort(1);
                                    },
                                    value: 1,
                                    child: PopupItem(
                                      icon: sortOptions[1],
                                      isSelected: currentIndex == 1,
                                      title: 'Most Upvotes',
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
                                  color: isDark
                                      ? kGrey40.withOpacity(0.6)
                                      : kLBlack10,
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
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  );
                }),
                childCount: snapshot.data!.docs.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

// SliverAppBar(
//           floating: true,
//           snap: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: kBackgroundColor,
//           expandedHeight: 70,
//           flexibleSpace: FlexibleSpaceBar(
//             background: SafeArea(
//               child: Padding(
//                   padding: EdgeInsets.only(
//                     left: size.width * 0.12,
//                     right: size.width * 0.12,
//                     top: 15,
//                     bottom: 15,
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       final snackBar = SnackBar(
//                         content: Text("SnackBar implementation"),
//                         action: SnackBarAction(
//                           label: "Done",
//                           onPressed: () {},
//                         ),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(snackBar)
//                           .closed
//                           .then((value) =>
//                               ScaffoldMessenger.of(context).clearSnackBars());
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       decoration: BoxDecoration(
//                           color: kGrey40,
//                           borderRadius: BorderRadius.circular(50),
//                           boxShadow: const [
//                             BoxShadow(
//                               offset: Offset(0, 2),
//                               color: kBlack15,
//                             ),
//                           ]),
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             "Search",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: kTextColor.withOpacity(0.5),
//                               letterSpacing: 1,
//                             ),
//                           ),
//                           const Spacer(),
//                           Icon(
//                             Icons.search_rounded,
//                             color: kTextColor.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                   // TextField(
//                   //   readOnly: true,
//                   //   onTap: () {},
//                   //   cursorColor: Colors.grey,
//                   //   decoration: InputDecoration(
//                   //     hintText: "Search...",
//                   //     hintStyle: TextStyle(),
//                   //     prefixIcon: Icon(
//                   //       Icons.search,
//                   //       color: kTextColor.withOpacity(0.5),
//                   //     ),
//                   //     filled: true,
//                   //     fillColor: kGrey30,
//                   //     border: outlineInputBorder,
//                   //     focusedBorder: outlineInputBorder,
//                   //     enabledBorder: outlineInputBorder,
//                   //   ),
//                   // ),
//                   ),
//             ),
//           ),
//         ),
