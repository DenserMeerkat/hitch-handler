import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/user_home/search_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../constants.dart';
import '../components/utils/customdialog.dart';
import 'feed/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import '../../providers/user_provider.dart';
// import '../../models/user.dart' as model;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IconData> sortOptions = [
    Icons.hourglass_empty_outlined,
    MdiIcons.fromString("arrow-up-bold-outline")!,
  ];
  int currentIndex = 0;
  IconData currentIcon = Icons.hourglass_empty_outlined;
  final ScrollController myScrollController = ScrollController();
  final StreamController<List<DocumentSnapshot>> _streamController1 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  final StreamController<List<DocumentSnapshot>> _streamController2 =
      StreamController<List<DocumentSnapshot>>.broadcast();

  final List<DocumentSnapshot> _posts = [];
  bool _isRequesting = false;
  bool _isFinish = false;
  static const int postLimit = 6;

  @override
  void initState() {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      return onChangeData(event.docChanges);
    });
    requestNextPage(currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    myScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
          requestNextPage(currentIndex);
        }
        return true;
      },
      child: StreamBuilder<List<DocumentSnapshot>>(
        stream: currentIndex == 0
            ? _streamController1.stream
            : _streamController2.stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            controller: myScrollController,
            shrinkWrap: true,
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
                            transitionDuration:
                                const Duration(milliseconds: 300),
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
                                        color:
                                            isDark ? kTextColor : kLTextColor,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 4, 0, 4),
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
                                        if (currentIndex != 0) {
                                          changeSort(0);
                                        }
                                      },
                                      value: 0,
                                      child: PopupItem(
                                        icon: sortOptions[0],
                                        isSelected: currentIndex == 0,
                                        title: 'Upload Time',
                                      ),
                                    ),
                                    PopupMenuItem<int>(
                                      height: 40,
                                      onTap: () {
                                        if (currentIndex != 1) {
                                          changeSort(1);
                                        }
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
                      snap: snapshot.data![index].data(),
                    );
                  }),
                  childCount: snapshot.data!.length,
                ),
              ),
              SliverOffstage(
                offstage: !(_posts.isNotEmpty && !_isFinish),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: isDark ? kGrey40 : kLGrey30),
                      ),
                      color:
                          isDark ? kGrey30.withOpacity(0.5) : kLBackgroundColor,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(border: Border()),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void changeSort(int index) {
    setState(() {
      currentIndex = index;
      currentIcon = sortOptions[index];
      debugPrint("$currentIndex");
      _posts.clear();
      _isFinish = false;
      Future.delayed(
        const Duration(milliseconds: 10),
        () => requestNextPage(index),
      );
    });
  }

  void onChangeData(List<DocumentChange> documentChanges) {
    var isChange = false;
    documentChanges.forEach((postChange) {
      if (postChange.type == DocumentChangeType.removed) {
        _posts.removeWhere((product) {
          return postChange.doc.id == product.id;
        });
        isChange = true;
      } else if (postChange.type == DocumentChangeType.added) {
        if (postChange.newIndex < _posts.length) {
          _posts.insert(0, postChange.doc);
        }
        isChange = true;
      } else {
        if (postChange.type == DocumentChangeType.modified) {
          int indexWhere = _posts.indexWhere((product) {
            return postChange.doc.id == product.id;
          });

          if (indexWhere >= 0) {
            _posts[indexWhere] = postChange.doc;
          }
          isChange = true;
        }
      }
    });

    if (isChange) {
      if (currentIndex == 0) {
        _streamController1.add(_posts);
      } else {
        _streamController2.add(_posts);
      }
    }
  }

  void requestNextPage(int index) async {
    if (!_isRequesting && !_isFinish) {
      QuerySnapshot querySnapshot;
      _isRequesting = true;
      if (_posts.isEmpty) {
        querySnapshot = index == 0
            ? await FirebaseFirestore.instance
                .collection('posts')
                .orderBy('datePublished', descending: true)
                .limit(postLimit)
                .get()
            : await FirebaseFirestore.instance
                .collection('posts')
                .orderBy('upVoteCount', descending: true)
                .limit(postLimit)
                .get();
      } else {
        querySnapshot = index == 0
            ? await FirebaseFirestore.instance
                .collection('posts')
                .orderBy('datePublished', descending: true)
                .startAfterDocument(_posts[_posts.length - 1])
                .limit(postLimit)
                .get()
            : await FirebaseFirestore.instance
                .collection('posts')
                .orderBy('upVoteCount', descending: true)
                .startAfterDocument(_posts[_posts.length - 1])
                .limit(postLimit)
                .get();
      }

      int oldSize = _posts.length;
      _posts.addAll(querySnapshot.docs);
      int newSize = _posts.length;
      if (oldSize != newSize) {
        if (currentIndex == 0) {
          _streamController1.add(_posts);
        } else {
          _streamController2.add(_posts);
        }
      } else {
        setState(() {
          _isFinish = true;
        });
      }
      setState(() {
        _isRequesting = false;
      });
    }
  }
}
