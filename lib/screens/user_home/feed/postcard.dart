import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/user.dart' as model;
import '../../../constants.dart';
import '../../../providers/user_provider.dart';
import 'postfooter.dart';
import 'postheader.dart';
import 'postimages.dart';

class PostCard extends StatefulWidget {
  final dynamic snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List imgList = [];

  late String location;
  late String date;
  late String time;
  late DateTime tempDate;
  late String timeAgo;

  @override
  void initState() {
    location = widget.snap['location'];
    date = widget.snap['date'];
    time = widget.snap['time'];
    imgList = widget.snap['imgList'];
    tempDate = DateTime.fromMicrosecondsSinceEpoch(
        widget.snap['datePublished'].microsecondsSinceEpoch);
    timeAgo = timeago.format(
      tempDate,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
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
        children: [
          PostTop(widget: widget),
          PostTitle(widget: widget),
          PostDesc(widget: widget),
          PostImages(widget: widget, imgList: imgList),
          ActionButtons(snap: widget.snap, user: user),
          PostInfo(location: location, date: date, time: time, widget: widget),
          PostTimeAgo(timeAgo: timeAgo, isDark: isDark),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
