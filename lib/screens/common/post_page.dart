// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/common/post/postfooter.dart';
import 'package:hitch_handler/screens/common/post/postheader.dart';
import 'package:hitch_handler/screens/common/post/postimages.dart';
import 'package:hitch_handler/screens/common/post/posttop.dart';
import 'package:hitch_handler/screens/components/utils/skeletons.dart';
import 'package:hitch_handler/screens/components/utils/tiles.dart';

class PostsPage extends StatefulWidget {
  static String routeName = '/posts_page';
  const PostsPage({
    super.key,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List imgList = [];

  late String location;
  late String date;
  late String time;
  late DateTime tempDate;
  late String timeAgo;

  Future<Map<String, dynamic>> getPostDetails(String pid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var db = firestore.collection('posts').doc(pid);
    var docs = await db.get();
    Map<String, dynamic> snap = docs.data()!;

    location = snap['location'];
    date = snap['date'];
    time = snap['time'];
    imgList = snap['imgList'];
    tempDate = DateTime.fromMicrosecondsSinceEpoch(
        snap['datePublished'].microsecondsSinceEpoch);
    timeAgo = timeago.format(
      tempDate,
    );
    return snap;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    requestNextPage();
  }

  void requestNextPage() async {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as PostsArguments;

    QuerySnapshot querySnapshot;
    setState(() {
      _isRequesting = true;
    });
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var db = firestore.collection('posts').doc(arguments.snap['postId']);
    var docs = await db.get();
    Map<String, dynamic> snap = docs.data()!;
    querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(snap['postId'])
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .get();

    if (!mounted) return;
    setState(() {
      logs.addAll(querySnapshot.docs);
      streamController.add(logs);
      _isRequesting = false;
    });
    debugPrint("bye");
  }

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();
  final List<DocumentSnapshot> logs = [];
  bool _isRequesting = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as PostsArguments;
    late String? location;
    late String? date;
    late String? time;
    late DateTime tempDate;
    late String timeAgo;
    final snap = arguments.snap;
    final bool isAuthority = arguments.isAuthority;
    location = snap['location'];
    date = snap['date'];
    time = snap['time'];
    imgList = snap['imgList'];
    tempDate = DateTime.fromMicrosecondsSinceEpoch(
        snap['datePublished'].microsecondsSinceEpoch);
    timeAgo = timeago.format(
      tempDate,
    );
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              "View Post",
              style: AdaptiveTheme.of(context)
                  .theme
                  .textTheme
                  .displayMedium!
                  .copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
            backgroundColor: isDark ? kBackgroundColor : kLBlack20,
            surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
            shadowColor: isDark ? kGrey30 : kLGrey30,
            leading: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: IconButton(
                      splashColor: splash(isDark),
                      focusColor: splash(isDark),
                      highlightColor: splash(isDark),
                      hoverColor: splash(isDark),
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                height: 1,
                color: isDark ? kGrey40 : kLGrey40,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 200,
              ),
              decoration: BoxDecoration(
                color: isDark ? kGrey30.withOpacity(0.5) : kLBackgroundColor,
                border: Border(
                  top: BorderSide(color: isDark ? kGrey40 : kLGrey30),
                  bottom: BorderSide(color: isDark ? kGrey40 : kLGrey30),
                ),
                //borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PostTop(
                    snap: snap,
                    isAuthority: isAuthority,
                    isViewPage: true,
                  ),
                  PostTitle(snap: snap, isAuthority: isAuthority),
                  PostDesc(snap: snap),
                  PostImages(snap: snap, imgList: imgList),
                  ActionButtons(
                    snap: snap,
                    user: user,
                    isAuthority: isAuthority,
                    showOpen: false,
                  ),
                  PostInfo(
                      location: location,
                      date: date,
                      time: time,
                      widget: widget,
                      isAuthority: isAuthority),
                  PostTimeAgo(timeAgo: timeAgo, isAuthority: isAuthority),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 360.w,
              height: 1.5,
              color: isDark ? kGrey30 : kLBlack20,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: BoxDecoration(
                    color: isDark ? kGrey30 : kLBlack20,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storage_rounded,
                      size: 20,
                      color: isDark ? kTextColor : kLTextColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Status Logs",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDark ? kTextColor : kLTextColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<List<DocumentSnapshot>>(
                  stream: streamController.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                    if (_isRequesting ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(height: 16),
                            StatusTileSkeleton(),
                            StatusTileSkeleton(),
                          ],
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? kGrey30
                                      : kLBlack15.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: isDark ? kGrey50 : kLBlack20,
                                      width: 2),
                                ),
                                child: ListTile(
                                  dense: true,
                                  leading: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.radio_button_checked,
                                      size: 20,
                                      color: isDark ? kTextColor : kLTextColor,
                                    ),
                                  ),
                                  title: AutoSizeText(
                                    "In Review",
                                    style: TextStyle(
                                        color:
                                            isDark ? kTextColor : kLTextColor,
                                        fontSize: 14,
                                        letterSpacing: 1),
                                  ),
                                  subtitle: AutoSizeText(
                                    "<First Log>",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isDark
                                            ? kTextColor.withOpacity(0.7)
                                            : kLTextColor.withOpacity(0.7)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    List<Widget> list = [];
                    for (int index = 0;
                        index < snapshot.data!.length;
                        index += 1) {
                      dynamic snap = snapshot.data![index].data();
                      int statusIndex = snap['newStatus'] == "In Review"
                          ? 0
                          : snap['newStatus'] == "Working"
                              ? 1
                              : 2;
                      IconData leading = PostTop.status[statusIndex].icon;
                      Color iconColor = PostTop.status[statusIndex].color;
                      String statusTitle = PostTop.status[statusIndex].title;
                      list.add(
                        StatusTile(
                          index: index,
                          isDark: isDark,
                          iconColor: iconColor,
                          leading: leading,
                          statusTitle: statusTitle,
                          snap: snap,
                        ),
                      );
                    }
                    return Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          ...list,
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
