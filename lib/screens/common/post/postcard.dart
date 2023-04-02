import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/common/post/posttop.dart';
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
  final bool isAuthority;
  const PostCard({
    super.key,
    required this.snap,
    this.isAuthority = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List imgList = [];

  late String location;
  late String? date;
  late String? time;
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
  void dispose() {
    super.dispose();
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostTop(
            snap: widget.snap,
            isAuthority: widget.isAuthority,
          ),
          PostTitle(snap: widget.snap, isAuthority: widget.isAuthority),
          PostDesc(snap: widget.snap),
          PostImages(snap: widget.snap, imgList: imgList),
          ActionButtons(
              snap: widget.snap, user: user, isAuthority: widget.isAuthority),
          PostInfo(
              location: location,
              date: date,
              time: time,
              widget: widget,
              isAuthority: widget.isAuthority),
          PostTimeAgo(timeAgo: timeAgo, isAuthority: widget.isAuthority),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
