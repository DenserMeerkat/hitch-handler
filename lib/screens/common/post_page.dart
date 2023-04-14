// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/common/post/postfooter.dart';
import 'package:hitch_handler/screens/common/post/postheader.dart';
import 'package:hitch_handler/screens/common/post/postimages.dart';
import 'package:hitch_handler/screens/common/post/posttop.dart';

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
  void initState() {
    super.initState();
  }

  String getCurrentTheme() {
    switch (AdaptiveTheme.of(context).mode) {
      case AdaptiveThemeMode.system:
        return "System Default";
      case AdaptiveThemeMode.light:
        return "Light Theme";
      case AdaptiveThemeMode.dark:
        return "Dark Theme";
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as PostsArguments;
    late String location;
    late String date;
    late String time;
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
              margin: const EdgeInsets.only(bottom: 10),
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
                  PostTop(snap: snap, isAuthority: isAuthority),
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
          )
        ],
      ),
    );
  }
}
