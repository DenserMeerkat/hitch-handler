import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../models/user.dart' as model;
import '../../providers/user_provider.dart';
import '../user_home/feed/postfooter.dart';
import '../user_home/feed/postheader.dart';
import '../user_home/feed/postimages.dart';
import '../../args_class.dart';

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
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var db = _firestore.collection('posts').doc(pid);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              "View Post",
              style: AdaptiveTheme.of(context).theme.textTheme.headlineMedium,
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
                  PostTop(snap: snap),
                  PostTitle(snap: snap),
                  PostDesc(snap: snap),
                  PostImages(snap: snap, imgList: imgList),
                  ActionButtons(
                    snap: snap,
                    user: user,
                    showOpen: false,
                  ),
                  PostInfo(
                      location: location, date: date, time: time, widget: snap),
                  PostTimeAgo(timeAgo: timeAgo, isDark: isDark),
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
