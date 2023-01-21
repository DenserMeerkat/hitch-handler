import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../resources/firestore_methods.dart';
import 'postcard.dart';
import '../../../constants.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
    required this.location,
    required this.date,
    required this.time,
    required this.widget,
  });

  final String location;
  final String date;
  final String time;
  final PostCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: kTextColor.withOpacity(0.1),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    location != "" ? location : "Location",
                  ),
                ),
                const Text("•"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(date),
                ),
                const Text("•"),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(time),
                ),
              ],
            ),
          ),
          Divider(
            color: kTextColor.withOpacity(0.1),
          ),
          const SizedBox(
            height: 5,
          ),
          ExpandableText(
            widget.snap['description'],
            style: TextStyle(
              fontSize: 14,
              color: kTextColor.withOpacity(0.7),
            ),
            expandOnTextTap: true,
            collapseOnTextTap: true,
            expandText: 'show more',
            collapseText: ' \tshow less',
            maxLines: 2,
            linkColor: Colors.white,
            linkStyle: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final snap;
  final user;
  const ActionButtons({
    super.key,
    required this.snap,
    required this.user,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  Widget commentCount() {
    //Todo
    return Text(
      "0",
      style: TextStyle(color: Colors.blueGrey[400]),
    );
  }

  bool isUpVoted = false;
  int upVoteCount = 0;

  bool isBookmarked = false;
  @override
  void initState() {
    isUpVoted = widget.snap['upVotes'].contains(widget.user.uid) ? true : false;
    upVoteCount = widget.snap['upVotes'].length;
    isBookmarked =
        widget.user.bookmarks.contains(widget.snap['postId']) ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      String res = "";
      bool success = false;
      try {
        res = await FirestoreMethods().upVotePost(
            widget.snap['postId'], widget.user.uid, widget.snap['upVotes']);
      } catch (err) {
        res = "$err";
        return isLiked;
      }
      if (res == "success") {
        success = true;
      }
      return success ? !isLiked : isLiked;
    }

    Future<bool> onBookmarkTapped(bool isLiked) async {
      String res = "";
      bool success = false;
      try {
        res = await FirestoreMethods().bookmarkPost(
            widget.snap['postId'], widget.user.uid, widget.user.bookmarks);
      } catch (err) {
        res = "$err";
        return isLiked;
      }
      if (res == "success") {
        success = true;
      }
      return success ? !isLiked : isLiked;
    }

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10),
      child: Row(
        children: [
          LikeButton(
            size: 30,
            likeCountPadding: const EdgeInsets.only(left: 6, right: 8),
            likeCountAnimationDuration: const Duration(milliseconds: 200),
            circleColor:
                const CircleColor(start: Color(0xff0099cc), end: kPrimaryColor),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: kPrimaryColor,
              dotSecondaryColor: Color(0xff0099cc),
            ),
            isLiked: isUpVoted,
            likeBuilder: (bool isUpVoted) {
              return Icon(
                isUpVoted
                    ? MdiIcons.fromString("arrow-up-bold")
                    : MdiIcons.fromString("arrow-up-bold-outline"),
                color: isUpVoted ? kPrimaryColor : kTextColor.withOpacity(0.8),
                size: isUpVoted ? 30 : 25,
              );
            },
            likeCount: upVoteCount,
            countBuilder: (likeCount, isLiked, text) {
              return Text(
                "$likeCount",
                style: TextStyle(color: isLiked ? kPrimaryColor : kTextColor),
              );
            },
            // countDecoration: (count, likeCount) {
            //   return Text(
            //     "$likeCount",
            //     style: TextStyle(color: isUpVoted ? kPrimaryColor : kTextColor),
            //   );
            // },
            onTap: onLikeButtonTapped,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      color: Colors.blueGrey[400],
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    commentCount(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.lightBlue[200],
                  size: 23,
                ),
              ),
            ),
          ),
          const Spacer(),
          LikeButton(
            size: 25,
            likeCountAnimationDuration: const Duration(milliseconds: 200),
            circleColor:
                const CircleColor(start: Color(0xff00ddff), end: kErrorColor),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: kErrorColor,
              dotSecondaryColor: Color(0xff0099cc),
            ),
            isLiked: isBookmarked,
            onTap: onBookmarkTapped,
            likeBuilder: (bool isBookmarked) {
              return Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? kErrorColor : kErrorColor,
                size: 25,
              );
            },
          ),
        ],
      ),
    );
  }
}
