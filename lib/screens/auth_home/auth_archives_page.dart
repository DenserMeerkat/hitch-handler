import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/components/utils/postsskeleton.dart';
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../providers/user_provider.dart';
import '../common/post/postcard.dart';
import '../../constants.dart';
import '../../models/user.dart' as model;

class AuthArchivesPage extends StatefulWidget {
  const AuthArchivesPage({super.key});

  @override
  State<AuthArchivesPage> createState() => _AuthArchivesPageState();
}

class _AuthArchivesPageState extends State<AuthArchivesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  int currentIndex = 0;
  final StreamController<List<DocumentSnapshot>> _streamController1 =
      StreamController<List<DocumentSnapshot>>.broadcast();
  final StreamController<List<DocumentSnapshot>> _streamController2 =
      StreamController<List<DocumentSnapshot>>.broadcast();

  final List<DocumentSnapshot> _posts = [];
  final List<DocumentSnapshot> _bookmarks = [];
  bool _isRequesting = false;
  bool _isFinish = false;
  bool _isRequesting1 = false;
  bool _isFinish1 = false;
  static const int postLimit = 6;

  void onChangeData(List<DocumentChange> documentChanges) {
    var isChange = false;
    for (var postChange in documentChanges) {
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
    }

    if (isChange) {
      _streamController1.add(_posts);
    }
  }

  void onChangeData1(List<DocumentChange> documentChanges) {
    var isChange = false;
    for (var postChange in documentChanges) {
      if (postChange.type == DocumentChangeType.removed) {
        _bookmarks.removeWhere((product) {
          return postChange.doc.id == product.id;
        });
        isChange = true;
      } else if (postChange.type == DocumentChangeType.added) {
        if (postChange.newIndex < _bookmarks.length) {
          _bookmarks.insert(0, postChange.doc);
        }
        isChange = true;
      } else {
        if (postChange.type == DocumentChangeType.modified) {
          int indexWhere = _bookmarks.indexWhere((product) {
            return postChange.doc.id == product.id;
          });

          if (indexWhere >= 0) {
            _bookmarks[indexWhere] = postChange.doc;
          }
          isChange = true;
        }
      }
    }

    if (isChange) {
      _streamController1.add(_bookmarks);
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _refreshController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    addData();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _handleTabSelection();
    });
    FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: user.uid)
        .snapshots()
        .listen((event) {
      return onChangeData(event.docChanges);
    });
    FirebaseFirestore.instance
        .collection('posts')
        .where('bookmarks', arrayContains: user.uid)
        .snapshots()
        .listen((event) {
      return onChangeData1(event.docChanges);
    });
    requestNextPage(0);
    super.initState();
  }

  void _handleTabSelection() {
    if (currentIndex != _tabController.index) {
      setState(() {
        currentIndex = _tabController.index;
      });
    }
    requestNextPage(currentIndex);
    if (currentIndex == 0) {
      _isFinish = false;
      requestNextPage(0);
      _streamController1.add(_posts);
    } else {
      _isFinish1 = false;
      requestNextPage(1);
      _streamController2.add(_bookmarks);
    }
  }

  void requestNextPage(int index) async {
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    if (currentIndex == 0
        ? !_isRequesting && !_isFinish
        : !_isRequesting1 && !_isFinish1) {
      QuerySnapshot querySnapshot;
      if (currentIndex == 0) {
        setState(() {
          _isRequesting = true;
        });
      } else {
        setState(() {
          _isRequesting1 = true;
        });
      }
      if (currentIndex == 0 ? _posts.isEmpty : _bookmarks.isEmpty) {
        querySnapshot = index == 0
            ? await FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: user.uid)
                .limit(postLimit)
                .get()
            : await FirebaseFirestore.instance
                .collection('posts')
                .where('bookmarks', arrayContains: user.uid)
                .limit(postLimit)
                .get();
      } else {
        querySnapshot = index == 0
            ? await FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: user.uid)
                .startAfterDocument(_posts[_posts.length - 1])
                .limit(postLimit)
                .get()
            : await FirebaseFirestore.instance
                .collection('posts')
                .where('bookmarks', arrayContains: user.uid)
                .startAfterDocument(_bookmarks[_bookmarks.length - 1])
                .limit(postLimit)
                .get();
      }
      int oldSize;
      int newSize;
      if (currentIndex == 0) {
        oldSize = _posts.length;
        _posts.addAll(querySnapshot.docs);
        newSize = _posts.length;
      } else {
        oldSize = _bookmarks.length;
        _bookmarks.addAll(querySnapshot.docs);
        newSize = _bookmarks.length;
      }
      if (oldSize != newSize) {
        if (currentIndex == 0) {
          _streamController1.add(_posts);
        } else {
          _streamController2.add(_bookmarks);
        }
      } else {
        if (currentIndex == 0) {
          setState(() {
            _isFinish = true;
          });
        } else {
          setState(() {
            _isFinish1 = true;
          });
        }
      }
      if (currentIndex == 0) {
        setState(() {
          _isRequesting = false;
        });
      } else {
        setState(() {
          _isRequesting1 = false;
        });
      }
    }
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        AdaptiveTheme.of(context).brightness == Brightness.dark ? true : false;
    return Scaffold(
      backgroundColor: isDark ? Colors.transparent : kLBlack20,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.transparent : kLBlack20,
        surfaceTintColor: isDark ? Colors.transparent : kLBlack20,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.only(
              top: 10.0.h,
              left: 70.w,
              right: 70.w,
              bottom: 14.0.h,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: isDark ? kGrey40 : kLGrey40,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Container(
                  color: isDark ? kGrey30 : kLBlack10,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorWeight: 0.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: kBlack10,
                    unselectedLabelColor: isDark
                        ? kTextColor.withOpacity(0.8)
                        : kLTextColor.withOpacity(0.8),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                    splashBorderRadius: BorderRadius.circular(50.r),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: isDark
                          ? kPrimaryColor.withOpacity(0.9)
                          : kLPrimaryColor.withOpacity(0.8),
                      border: Border.all(
                        color: isDark ? kPrimaryColor : kLPrimaryColor,
                        width: 2,
                      ),
                    ),
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: "Your Posts",
                      ),
                      Tab(
                        text: "Bookmarks",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.5,
            color: isDark ? kGrey40 : kLGrey40,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              if (scrollInfo.metrics.maxScrollExtent - 40 <
                  scrollInfo.metrics.pixels) {
                requestNextPage(currentIndex);
              }
              return true;
            },
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: _streamController1.stream,
              initialData: _posts,
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot1) {
                if ((_isRequesting && _posts.isEmpty) ||
                    (snapshot1.connectionState == ConnectionState.waiting)) {
                  return const FeedSkeleton();
                }
                if (_isFinish && snapshot1.data!.isEmpty) {
                  return Center(
                      child: Container(
                    constraints:
                        BoxConstraints(minHeight: 280.h, maxHeight: 340.h),
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? kGrey30 : kLGrey40,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: isDark ? kGrey30.withOpacity(0.4) : kLGrey30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.post_add_rounded,
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
                          height: 40.h,
                          width: double.infinity,
                        ),
                        FittedBox(
                          child: Text(
                            "Posts you have made \nappear here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? kGrey150 : kGrey50,
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        FittedBox(
                          child: Text(
                            "You haven't made any posts yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? kGrey150 : kGrey50,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                }
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: !_isFinish,
                  header: const RefreshThemedHeader(),
                  footer: const LoadThemedFooter(),
                  onLoading: () {
                    requestNextPage(currentIndex);
                  },
                  controller: _refreshController,
                  onRefresh: () {
                    if (!mounted) return;
                    setState(() {
                      _isFinish = false;
                      requestNextPage(currentIndex);
                      _streamController1.add(_posts);
                    });
                    _refreshController.refreshCompleted();
                  },
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          ((context, index) {
                            dynamic snap = snapshot1.data![index].data();
                            return PostCard(
                              isAuthority: true,
                              key: ValueKey(snap['postId']),
                              snap: snap,
                            );
                          }),
                          childCount: snapshot1.data!.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              if (scrollInfo.metrics.maxScrollExtent - 40 <
                  scrollInfo.metrics.pixels) {
                requestNextPage(currentIndex);
              }
              return true;
            },
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: _streamController2.stream,
              initialData: _bookmarks,
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot2) {
                if ((_isRequesting1 && _bookmarks.isEmpty) ||
                    (snapshot2.connectionState == ConnectionState.waiting)) {
                  return const FeedSkeleton();
                }
                if (_isFinish1 && snapshot2.data!.isEmpty) {
                  return Center(
                      child: Container(
                    constraints:
                        BoxConstraints(minHeight: 280.h, maxHeight: 340.h),
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 30.h),
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
                            Icons.bookmark_added_outlined,
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
                            height: 40.h,
                            width: double.infinity,
                          ),
                          FittedBox(
                            child: Text(
                              "Your Bookmarked posts \nappear here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? kGrey150 : kGrey50,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          FittedBox(
                            child: Text(
                              "You haven't bookmarked any posts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? kGrey150 : kGrey50,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                }
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: !_isFinish1,
                  header: const RefreshThemedHeader(),
                  footer: const LoadThemedFooter(),
                  onLoading: () {
                    requestNextPage(currentIndex);
                  },
                  controller: _refreshController1,
                  onRefresh: () {
                    if (!mounted) return;
                    setState(() {
                      _isFinish = false;
                      requestNextPage(currentIndex);
                      _streamController2.add(_bookmarks);
                    });
                    _refreshController1.refreshCompleted();
                  },
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          ((context, index) {
                            dynamic snap = snapshot2.data![index].data();
                            return PostCard(
                              isAuthority: true,
                              key: ValueKey(snap['postId']),
                              snap: snap,
                            );
                          }),
                          childCount: snapshot2.data!.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
